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
"""Init module for Python Cloud Profiler."""

import logging
import sys
from googlecloudprofiler import __version__ as version
from googlecloudprofiler import client

_started = False

logger = logging.getLogger(__name__)


def start(service=None,
          service_version=None,
          project_id=None,
          service_account_json_file=None,
          verbose=0,
          disable_cpu_profiling=False,
          disable_wall_profiling=False,
          period_ms=10,
          discovery_service_url=None):
  """Starts the profiler.

  This function starts a daemon thread which polls the profiler server for
  instructions, and collects and uploads profiles as requested. It should only
  be called once. Subsequent calls will be ignored. If wall profiling is
  enabled, this function must be called on the main thread.

  Args:
    service: A string specifying the name of the service under which the
      profiled data will be recorded and exposed at the profiler UI for the
      project. The string should be the same across different replicas of your
      service so that the globally constant profiling rate is maintained. Do not
      put things like PID or unique pod ID in the name. The string must match
      the regular expression '^[a-z]([-a-z0-9_.]{0,253}[a-z0-9])?$'. When not
      specified, the value of GAE_SERVICE environment variable will be used,
      which is set for applications running on Google App Engine; if GAE_SERVICE
      is not set,the value of K_VERSION environment variable, which is set on
      Knative containers, will be used. If specified neither here nor via an
      envrionment variable, a value error will be raised.
    service_version: An optional string specifying the version of the service.
      It can be an arbitrary string. Profiler profiles once per minute for each
      version of each service in each zone. It defaults to GAE_VERSION
      environment variable if that is set, to K_REVISION environment variable if
      that is set and GAE_VERSION is not set, and to empty string otherwise.
    project_id: A string specifying the cloud project ID. When not specified,
      the value can be read from the credential file or otherwise read from the
      VM metadata server. If specified neither here nor via the envrionment, a
      value error will be raised.
    service_account_json_file: An optional string providing the path to the
      service account json file. If not provided, application default
      credentials are used.
    verbose: An optional int specifying the logging level. Logging messages
      which are less severe than verbose will be ignored. 0-error, 1-warn,
      2-info, 3-debug. Defaults to error.
    disable_cpu_profiling: An optional bool specifying whether or not the CPU
      time profiling should be disabled. CPU profiling is only supported for
      Python 3.2 or higher. This flag is ignored on unsupported Python versions.
      Defaults to False.
    disable_wall_profiling: An optional bool specifying whether or not the Wall
      time profiling should be disabled. Wall profiling is supported for Python
      2 and Python 3.6 and higher. This flag is ignored on unsupported Python
      versions. It defaults to False for the supported versions. The current
      wall time profiling avoids dependency on any native code by using Python
      signal module. It only profiles the main thread. The start function must
      be called from the main thread if wall time profiling is enabled.
      Using SIGALRM signal after starting the profiler will cause problems:
      registering a handler for SIGALRM will prevent the profiler from
      working. SIGALRM will be trigger by the profiler at unpredictable time.
      Wall profiling has some other limitations as documented in the
      pythonprofiler module.
    period_ms: An optional integer specifying the sampling interval in
      milliseconds. Applies to both CPU profiling and wall profiling. Defaults
      to 10.
    discovery_service_url: Optional discovery service URL override. Only useful
      to developers of the profiler (to specify API key to use with a testing
      API endpoint).

  Raises:
    ValueError: If arguments are invalid or if necessary information can't be
      determined from the environment and arguments. Or if service name doesn't
      match '^[a-z]([-a-z0-9_.]{0,253}[a-z0-9])?$'. Or if called from
      a non-main thread when Wall time profiling is enabled. Or if no profiling
      mode is enabled.
    NotImplementedError: If not run on Linux or Mac.
  """
  global _started
  if _started:
    logger.warning('googlecloudprofiler.start() called again after it was '
                   'previously called. This function should only be called '
                   'once. This call is ignored.')
    return

  # Adds a StreamHandler with a default Formatter to the root logger.
  # It does nothing if the root logger already has handlers.
  logging.basicConfig()

  if not (sys.platform.startswith('linux') or
          sys.platform.startswith('darwin')):
    raise NotImplementedError('%s OS is not supported.' % (sys.platform))

  logging_level = [logging.ERROR, logging.WARNING, logging.INFO,
                   logging.DEBUG][min(verbose, 3)]
  logger.setLevel(logging_level)

  if sys.version_info < (3, 2):
    logger.warning(
        'Python version %d.%d is not supported. Minimum supported '
        'Python version is 3.2.', sys.version_info[0], sys.version_info[1])

  profiler_client = client.Client()
  project_id = profiler_client.setup_auth(project_id, service_account_json_file)
  profiler_client.config(project_id, service, service_version,
                         disable_cpu_profiling, disable_wall_profiling,
                         period_ms, discovery_service_url)
  logger.info('Google Cloud Profiler Python agent version: %s',
              version.__version__)
  profiler_client.start()

  _started = True
