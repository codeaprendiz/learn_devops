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
"""Implements profiler backoff."""

import errno
import json
import logging
import random
import googleapiclient
from google.protobuf import duration_pb2
from google.protobuf import json_format

logger = logging.getLogger(__name__)
_NANOS_PER_SEC = 1000 * 1000 * 1000


class Backoff(object):
  """This class calculates the backoff duration for a failed request.

  A backoff duration specified by the server is used if it presents in the
  error message. Otherwise exponential backoff is used. The actual duration is a
  random value between 0 and an envelope. The envelope starts from the specified
  minimum. It is exponentially increased between subsequent failures, up to the
  specified maximum.
  """

  def __init__(self,
               min_envelope_sec=60.0,
               max_envelope_sec=3600.0,
               multiplier=1.3):
    """Constructs a Backoff object.

    Args:
      min_envelope_sec: A float specifying the initial minimum backoff duration
        envelope in seconds.
      max_envelope_sec: A float specifying the maximum backoff duration envelope
        in seconds.
      multiplier: A float specifying the factor for exponential increase.
    """
    random.seed()
    self._min_envelope_sec = min_envelope_sec
    self._max_envelope_sec = max_envelope_sec
    self._multiplier = multiplier
    self._current_envelope_sec = min_envelope_sec

  def next_backoff(self, error=None):
    """Calculates the backoff duration for a failed request.

    Args:
      error: The exception that caused the failure.

    Returns:
      A float representing the desired backoff duration in seconds.
    """
    try:
      # Add short retry period for "broken pipe" exception. See b/158130635 for
      # more details.
      if isinstance(error, OSError) and error.errno == errno.EPIPE:
        broken_pipe_sec = random.uniform(1, 10)
        logger.warning('Agent will back off for %.3f seconds due to %s',
                       broken_pipe_sec, str(error))
        return broken_pipe_sec
      elif isinstance(error, googleapiclient.errors.HttpError):
        content = json.loads(error.content.decode('utf-8'))
        for detail in content.get('error', {}).get('details', []):
          if 'retryDelay' in detail:
            delay = duration_pb2.Duration()
            json_format.Parse(json.dumps(detail['retryDelay']), delay)
            return delay.seconds + float(delay.nanos) / _NANOS_PER_SEC
    # It's safe to catch BaseException because this runs in a daemon thread.
    except BaseException as e:  # pylint: disable=broad-except
      logger.warning(
          'Failed to extract server-specified backoff duration '
          '(will use exponential backoff): %s', str(e))

    duration = random.uniform(0, self._current_envelope_sec)
    self._current_envelope_sec = min(
        self._max_envelope_sec, self._current_envelope_sec * self._multiplier)
    return duration
