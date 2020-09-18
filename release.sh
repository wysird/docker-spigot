#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo -e "Please provide the version as the first parameter"
    exit 1
fi

for VERSION in $@; do
    docker tag spigot:${VERSION} docker.wysird.com:8443/repository/minecraft/spigot:${VERSION} && \
    docker tag spigot:${VERSION} wysird/spigot:${VERSION} && \
    docker push docker.wysird.com:8443/repository/minecraft/spigot:${VERSION} && \
    docker push wysird/spigot:${VERSION}
done

