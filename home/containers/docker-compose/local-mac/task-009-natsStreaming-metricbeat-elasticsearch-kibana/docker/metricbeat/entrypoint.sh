#!/usr/bin/env bash

wait_single_host() {
  local host=$1
  shift
  local port=$1
  shift

  echo "==> Check host ${host}:${port}"
  while ! nc ${host} ${port} > /dev/null 2>&1 < /dev/null; do echo "   --> Waiting for ${host}:${port}" && sleep 1; done;
}

wait_all_hosts() {
  if [ ! -z "$WAIT_FOR_HOSTS" ]; then
    local separator=':'
    for _HOST in $WAIT_FOR_HOSTS ; do
        IFS="${separator}" read -ra _HOST_PARTS <<< "$_HOST"
        wait_single_host "${_HOST_PARTS[0]}" "${_HOST_PARTS[1]}"
    done
  else
    echo "IMPORTANT : Waiting for nothing because no $WAIT_FOR_HOSTS env var defined !!!"
  fi
}

wait_all_hosts

#while ! curl -s -X GET ${HOST_ELASTICSEARCH}/_cluster/health\?wait_for_status\=yellow\&timeout\=60s | grep -q '"status":"green"'
#do
#    echo "==> Waiting for cluster YELLOW status" && sleep 1
#done
#
#echo ""
#echo "Cluster is YELLOW. Fine ! (But you could maybe try to have it GREEN ;))"
#echo ""

## to wait to http://kibana:5601/api/status to be up
sleep 60

bash -c "/usr/local/bin/docker-entrypoint $*"
