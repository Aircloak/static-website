#!/usr/bin/env bash

set -eo pipefail

function named_container_running {
  if [ -z "$(docker ps --filter=name=$1 | grep -v CONTAINER)" ]; then
    return 1
  else
    return 0
  fi
}

function gracefully_stop_container {
  STOP_SIGNAL=${STOP_SIGNAL:-SIGTERM}
  echo "Sending $STOP_SIGNAL to container $1 for graceful shutdown"
  docker kill -s $STOP_SIGNAL $1 > /dev/null
}

function stop_named_container {
  if named_container_running $1; then
    gracefully_stop_container $1

    STOP_TIMEOUT=${STOP_TIMEOUT:-10}
    echo "Waiting max $STOP_TIMEOUT sec for container $1 to stop"
    retry=1
    while named_container_running $1 && [ $retry -lt $STOP_TIMEOUT ]; do
      retry=$((retry+1))
      sleep 1
    done

    if named_container_running $1; then
      echo "Forcefully terminating container $1"
      docker kill $1 > /dev/null
    else
      echo "Container $1 stopped gracefully"
    fi
  fi

  if [ ! -z "$(docker ps -a --filter=name=$1 | grep -v CONTAINER)" ]; then
    echo "Removing container $1"
    docker rm $1 > /dev/null
  fi
}

function container_ctl {
  container_name=$1
  shift

  command=$1
  shift

  if [ "$AIR_ENV" = "prod" ]; then
    driver_arg="--log-driver=syslog"
  fi

  case "$command" in
    start)
      stop_named_container $container_name
      echo "Starting container $container_name"
      docker run -d $driver_arg --restart on-failure --name $container_name "$@"
      ;;

    ensure_started)
      RUNNING=$(docker inspect --format="{{ .State.Running }}" $container_name || echo false)
      if [ "$RUNNING" != "true" ]; then
        echo "Starting container $container_name"
        docker run -d $driver_arg --restart on-failure --name $container_name "$@"
      fi
      ;;

    console)
      stop_named_container $container_name
      docker run --rm -it --name $container_name "$@"
      ;;

    remsh)
      docker exec -i -t $container_name /bin/bash
      ;;

    stop)
      stop_named_container $container_name
      exit 0
      ;;

    *)
      echo "$(basename $0) start|stop|ensure_started|remsh|console docker-args"
      exit 1
      ;;

  esac
}

STOP_SIGNAL=SIGQUIT
STOP_TIMEOUT=30

container_ctl static_website_stage \
  "$@" -p 10001:10000 \
  aircloak/static_website:latest \
  /aircloak/run.sh

