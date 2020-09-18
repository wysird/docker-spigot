#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo -e "Please provide the version as the first parameter"
    exit 1
fi

function docker-prune() {
    echo -e 'Pruning all things docker...\n\n' && \
    echo -e 'Pruning builds...\n' && \
    docker builder prune -af && \
    echo -e '\nPruning containers...\n' && \
    docker container prune -f && \
    echo -e '\nPruning images...\n' && \
    docker image prune -af && \
    echo -e '\nPruning networks...\n' && \
    docker network prune -f && \
    echo -e '\nPruning system...\n' && \
    docker system prune -af && \
    echo -e '\nPruning volumes...\n' && \
    docker volume prune -f && \
    echo -e '\n\nPruning complete.'
}

for VERSION in $@; do
    docker-prune
    ./build.sh ${VERSION}
    ./release.sh ${VERSION}
done