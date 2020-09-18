#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo -e "Please provide the version as the first parameter"
    exit 1
fi

for VERSION in $@; do
    sed "s/<VERSION>/${VERSION}/g" Dockerfile.template > Dockerfile

    docker build . -t spigot:${VERSION}
done

