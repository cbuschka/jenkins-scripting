#!/bin/bash

BASE_DIR=$(cd `dirname $0` && pwd)

DATA_DIR=$BASE_DIR/data-volume
mkdir -p $DATA_DIR

function printUsage() {
  echo "$0 rm|run"
}

if [ -z "$1" ]; then
  printUsage
  exit 1
fi

while (( "$#" )); do
  cmd=$1
  shift
  echo $cmd
  case $cmd in
    build)
      docker build -t my-jenkins -f $BASE_DIR/my-jenkins/Dockerfile $BASE_DIR/my-jenkins
      ;;
    rm)
      docker rm -f my-jenkins
    ;;
    run)
      docker run --name my-jenkins -p 8080:8080 -p 50000:50000 -v $DATA_DIR:/var/jenkins_home my-jenkins
    ;;
    *)
      printUsage
      exit 1 
    ;;
  esac
done

