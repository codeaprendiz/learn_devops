# Copyright 2018 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""Communicates with the profiler backend over HTTP."""

import base64
import inspect
import json
import logging
import os
import re
import sys
import threading
import time
import traceback

import google.auth
from google.oauth2 import service_account
import google_auth_httplib2
import googleapiclient
import googleapiclient.discovery
import googleapiclient.errors
from googlecloudprofiler import __version__ as version
from googlecloudprofiler import backoff
# pylint: disable=g-import-not-at-top
if sys.platform.startswith('linux'):
  from googlecloudprofiler import cpu_profiler
else:
  # CPU profiling is only supported on Linux.
  cpu_profiler = None
from googlecloudprofiler import pythonprofiler
import httplib2
import requests
from google.protobuf import duration_pb2
from google.protobuf import json_format

# This module sometimes catches the general BaseException. This is safe because
# it runs in a daemon thread. Signal is always handled by the main thread, so we
# are not blocking user interruptions such as Ctrl+C. We need to catch the
# general exception sometimes because we can't predict what exception the HTTP
# client can throw.

# Auth scope to use for the profiler API calls.
_SCOPE = ['https://www.googleapis.com/auth/monitoring.write']

_GCE_METADATA_URL = 'http://metadata/computeMetadata/v1/'
_GCE_METADATA_HEADERS = {'Metadata-Flavor': 'Google'}

_SERVICE_VERSION_LABEL = 'version'
_INSTANCE_LABEL = 'instance'
_ZONE_LABEL = 'zone'
_LANGUAGE_LABEL = 'language'

_PROFILER_SERVICE_TIMEOUT_SEC = 60 * 60

_NANOS_PER_SEC = 1000 * 1000 * 1000

logger = logging.getLogger(__name__)


def retrieve_gce_metadata(metadata_key):
  """Retrieves the metadata for the given key from the GCE metadata server.

  Args:
    metadata_key: A string specifying the metadata key, e.g
      'project/project-id'. See
      https://cloud.google.com/compute/docs/storing-retrieving-metadata for the
      list of keys.

  Returns:
    A string representing the metadata value, or None if not found.
  """
  url = _GCE_METADATA_URL + metadata_key
  try:
    response = requests.get(url, headers=_GCE_METADATA_HEADERS)
    if response.status_code == requests.codes.ok:
      return response.text
  except BaseException as e:
    # Ignore any exceptions.
    logger.warning('Failed to fetch %s from GCE metadata server: %s',
                   metadata_key, str(e))
  return None


class Client(object):
  """Communicates with the profiler backend over HTTP."""

  def __init__(self):
    self._backoff = backoff.Backoff()
    self._filter_log()
    self._started = False
    self._profiler_service = None

  def setup_auth(self, project_id=None, service_account_json_file=None):
    """Sets up authentication with Google APIs.

    This will use the credentials from service_account_json_file if provided,
    falling back to application default credentials. See
    https://cloud.google.com/docs/authentication/production.

    Args:
      project_id: A string specifying the GCP project ID (e.g. my-project). If
        not provided, will attempt to retrieve it from the credentials.
      service_account_json_file: A string specifying the path to a service
        account json file. If not provided, will default to application default
        credentials.

    Returns:
      A string representing the project ID.
    """
    if service_account_json_file:
      self._credentials = (
          service_account.Credentials.from_service_account_file(
              service_account_json_file, scopes=_SCOPE))
      if not project_id:
        with open(service_account_json_file) as f:
          project_id = json.load(f).get('project_id')
    else:
      self._credentials, credentials_project_id = google.auth.default(
          scopes=_SCOPE)
      project_id = project_id or credentials_project_id
    return project_id

  def config(self, project_id, service, service_version, disable_cpu_profiling,
             disable_wall_profiling, period_ms, discovery_service_url):
    """Sets up the client config.

    Args:
      project_id: A string specifying the cloud project ID. When not specified,
        the value can be read from the credential file or otherwise read from
        the VM metadata server. If specified neither here nor via the
        envrionment, a value error will be raised.
      service: A string specifying the name of the service under which the
        profiled data will be recorded and exposed at the profiler UI for the
        project. If specified neither here nor via the envrironment variable
        GAE_SERVICE or the environment variable K_SERVICE, a value error will be
        raised. See docs in __init__.py for more details.
      service_version: A string specifying the version of the service. See docs
        in __init__.py for more details.
      disable_cpu_profiling: A bool specifying whether or not the CPU time
        profiling should be disabled. See docs in __init__.py for more details.
      disable_wall_profiling: A bool specifying whether or not the WALL time
        profiling should be disabled. See docs in __init__.py for more details.
      period_ms: An integer specifying the sampling interval in milliseconds.
      discovery_service_url: A URL that points to the location of the discovery
        service.

    Raises:
      ValueError: If the project ID or service can't be determined from the
        environment and arguments. Or if service name doesn't match
        '^[a-z]([-a-z0-9_.]{0,253}[a-z0-9])?$'. Or if no profiling mode is
        enabled.
    """
    self._profilers = {}
    self._config_cpu_profiling(disable_cpu_profiling, period_ms)
    self._config_wall_profiling(disable_wall_profiling, period_ms)
    if not self._profilers:
      raise ValueError('No profiling mode is enabled.')

    project_id = project_id or retrieve_gce_metadata('project/project-id')
    if not project_id:
      raise ValueError(
          'Unable to determine the project ID from the environment. '
          'project ID mush be provided if running outside of GCP.')

    service = service or os.environ.get('GAE_SERVICE') or os.environ.get(
        'K_SERVICE')
    if not service:
      raise ValueError('Service name must be provided via configuration or '
                       'GAE_SERVICE environment variable.')
    service_re = re.compile('^[a-z]([-a-z0-9_.]{0,253}[a-z0-9])?$')
    if not service_re.match(service):
      raise ValueError('Service name "%s" does not match regular expression '
                       '"%s"' % (service, service_re.pattern))
    deployment_labels = {_LANGUAGE_LABEL: 'python'}
    service_version = service_version or os.environ.get(
        'GAE_VERSION') or os.environ.get('K_REVISION')
    if service_version:
      deployment_labels[_SERVICE_VERSION_LABEL] = service_version
    zone = retrieve_gce_metadata('instance/zone')
    if zone:
      deployment_labels[_ZONE_LABEL] = zone.split('/')[-1]

    self._deployment = {
        'projectId': project_id,
        'target': service,
        'labels': deployment_labels,
    }

    self._profile_labels = {}
    instance = retrieve_gce_metadata('instance/name')
    if instance:
      self._profile_labels[_INSTANCE_LABEL] = instance

    self._discovery_service_url = googleapiclient.discovery.DISCOVERY_URI
    if discovery_service_url:
      self._discovery_service_url = discovery_service_url

  def start(self):
    """Starts collecting profiles.

    Starts an endless daemon thread that polls the profiler server, and collects
    and uploads profiles as requested.

    Raises:
      ValueError: If called from a non-main thread when Wall time profiling
        is enabled.
    """
    if self._started:
      logger.warning('Profiler already started, will not start again')
      return

    if 'WALL' in self._profilers:
      self._profilers['WALL'].register_handler()
    self._polling_thread = threading.Thread(target=self._poll_profiler_service)
    self._polling_thread.name = 'Profiler API polling thread'
    self._polling_thread.daemon = True
    self._polling_thread.start()

  def _config_cpu_profiling(self, disable_cpu_profiling, period_ms):
    """Adds CPU profiler if CPU profiling is supported and not disabled."""
    cpu_profiling_supported = cpu_profiler is not None
    if not cpu_profiling_supported:
      logger.info('CPU profiling is not supported on the current Operating '
                  'System. Linux is the only supported Operating System.')
    elif disable_cpu_profiling:
      logger.info('CPU profiling is disabled by disable_cpu_profiling')
    else:
      self._profilers['CPU'] = cpu_profiler.CPUProfiler(period_ms)

  def _config_wall_profiling(self, disable_wall_profiling, period_ms):
    """Adds wall profiler if wall profiling is supported and not disabled."""
    if disable_wall_profiling:
      logger.info('Wall profiling is disabled by disable_wall_profiling')
    else:
      self._profilers['WALL'] = pythonprofiler.WallProfiler(period_ms)

  def _build_service(self):
    """Builds a discovery client for talking to the Profiler."""
    http = httplib2.Http(timeout=_PROFILER_SERVICE_TIMEOUT_SEC)
    http = google_auth_httplib2.AuthorizedHttp(self._credentials, http)
    profiler_api = googleapiclient.discovery.build(
        'cloudprofiler',
        'v2',
        http=http,
        cache_discovery=False,
        requestBuilder=ProfilerHttpRequest,
        discoveryServiceUrl=self._discovery_service_url)
    return profiler_api.projects().profiles()

  def _create_profile(self):
    """Calls the profiler server for instructions on the next profile to create.

    The request hangs until the profiler server thinks it's the desired time
    to profile. In some cases, the server may also return an error containing
    a desired backoff duration.

    Returns:
      A Profile object containing necessary information, such as type and
      duration, to collect profile data.
    """
    profile_types = list(self._profilers.keys())
    request = {
        'profileType': profile_types,
        'deployment': self._deployment,
    }
    parent = 'projects/' + self._deployment['projectId']
    return self._profiler_service.create(parent=parent, body=request).execute()

  def _collect_and_upload_profile(self, profile):
    """Collects a profile and uploads to the profiler server."""
    try:
      profile_type = profile['profileType']
      if profile_type not in self._profilers:
        logger.warning('Unexpected profile type: %s', profile_type)
        return

      duration = duration_pb2.Duration()
      profile_duration = profile['duration']
      json_format.Parse(json.dumps(profile_duration), duration)
      duration_ns = duration.seconds * _NANOS_PER_SEC + duration.nanos

      profile_bytes = self._profilers[profile_type].profile(duration_ns)
      profile['profileBytes'] = base64.b64encode(profile_bytes).decode('UTF-8')
      logger.debug('Starting to upload profile')
      self._profiler_service.patch(
          name=profile['name'], body=profile).execute(num_retries=3)
    except BaseException:  # pylint: disable=broad-except
      logger.warning(
          'Failed to collect and upload profile whose profile type is %s: %s',
          profile_type, traceback.format_exc())

  def _poll_profiler_service(self):
    """Polls the profiler server stoplessly."""
    logger.debug('Profiler has started')
    build_service_backoff = backoff.Backoff()
    while self._profiler_service is None:
      try:
        self._profiler_service = self._build_service()
      except BaseException as e:  # pylint: disable=broad-except
        # Exponential backoff.
        backoff_duration = build_service_backoff.next_backoff()
        logger.error(
            'Failed to build the Discovery client for profiler '
            '(will retry after %.3fs): %s', backoff_duration, str(e))
        time.sleep(backoff_duration)

    while True:
      profile = None
      while not profile:
        try:
          logger.debug('Starting to create profile')
          profile = self._create_profile()
          self._backoff = backoff.Backoff()
          logger.debug('Successfully created a %s profile',
                       profile['profileType'])
        except BaseException as e:
          # Uses the server specified backoff duration if it is present in the
          # error message, otherwise uses exponential backoff.
          backoff_duration = self._backoff.next_backoff(e)
          logger.debug('Failed to create profile (will retry after %.3fs): %s',
                       backoff_duration, str(e))
          time.sleep(backoff_duration)

      self._collect_and_upload_profile(profile)

  def _filter_log(self):
    """Disables logging in the discovery API to avoid excessive logging."""

    class _ChildLogFilter(logging.Filter):
      """Filter to eliminate info-level logging when called from this module."""

      def __init__(self, filter_levels=None):
        super(_ChildLogFilter, self).__init__()
        self._filter_levels = filter_levels or set(logging.INFO)
        # Get name without extension to avoid .py vs .pyc issues
        self._my_filename = os.path.splitext(
            inspect.getmodule(_ChildLogFilter).__file__)[0]

      def filter(self, record):
        if record.levelno not in self._filter_levels:
          return True
        callerframes = inspect.getouterframes(inspect.currentframe())
        for f in callerframes:
          if os.path.splitext(f[1])[0] == self._my_filename:
            return False
        return True

    googleapiclient.discovery.logger.addFilter(_ChildLogFilter({logging.INFO}))


class ProfilerHttpRequest(googleapiclient.http.HttpRequest):
  """Attaches headers specific to the profiling agent.

  The x-goog-api-format-version header is needed for the newer error format.
  This format sets the retry info in a separate field in the error response.
  This makes it easier (or even possible) to retrieve the retry delay.

  The user-agent and x-goog-api-format-version headers are added
  (if not present) or updated (if already present) to note the version
  of the profiling agent.
  """

  def __init__(self, *args, **kwargs):
    headers = kwargs.setdefault('headers', {})
    headers['x-goog-api-format-version'] = '2'

    # user-agent and x-goog-api-client should be a space-separated list of
    # libraries and their versions.
    for (h, val) in [('user-agent',
                      'gcloud-python-profiler/' + version.__version__),
                     ('x-goog-api-client', 'gccl/' + version.__version__)]:
      if h in headers:
        headers[h] += ' '
      else:
        headers[h] = ''
      headers[h] += val

    super(ProfilerHttpRequest, self).__init__(*args, **kwargs)
