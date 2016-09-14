#!/usr/bin/env bash

set -eo pipefail

function print_usage {
  echo
  echo "Usage:"
  echo "  $0 stage|production"
  echo
}

function validate_target {
  case "$TARGET" in
    prod|stage)
      ;;
    *)
      print_usage
      exit 1
      ;;
  esac
}

function deploy {
  ssh acdbuild.mpi-sws.org "
    set -eo pipefail

    echo
    echo '----------------------------'
    echo
    echo 'Pulling the latest version'
    echo

    cd $BUILD_FOLDER
    git fetch
    git checkout $BRANCH
    git reset --hard origin/$BRANCH
    echo
    echo '----------------------------'
    echo
    echo '... once setup, we will copy the files to the $TARGET folder at this point'
  "
}

if [ $# -lt 1 ]; then
  print_usage
  exit 1
fi

TARGET=$1
validate_target

BUILD_FOLDER="/aircloak/static-website/$TARGET"
BRANCH=$(git symbolic-ref --short HEAD)

if [ "$BRANCH" != "master" ]; then
  echo "Warning: deploying from branch $BRANCH"
  read -p "Continue (y/N)? " -r
  if ! [[ $REPLY =~ ^[Yy]$ ]]; then exit 1; fi
fi

echo
echo "Deploying static website to target: $TARGET"
echo

deploy

echo
