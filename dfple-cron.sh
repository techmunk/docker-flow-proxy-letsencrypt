#!/bin/sh

# Backwards compat.
[ -z $DF_SWARM_LISTENER_SERVICE_ENDPOINT ] && [ -n $DF_SWARM_LISTENER_SERVICE_NAME ] && DF_SWARM_LISTENER_SERVICE_ENDPOINT="${DF_SWARM_LISTENER_SERVICE_NAME}:8080" 

# Ash doesn't support bash style arrays. Workaround.
OLDIFS="$IFS"
IFS=","

for endpoint in $DF_SWARM_LISTENER_SERVICE_ENDPOINT; do
  echo "CRON: Notifying $endpoint"
  curl "http://${endpoint}/v1/docker-flow-swarm-listener/notify-services"
done

IFS="$OLDIFS"

