#!/bin/bash

USED_JVM_ARGS=

if [ -z "${1}" ]; then
    echo -e "No version specified!"
    exit 1
fi

if [ ! -z "${JVM_ARGS}" ]; then
    USED_JVM_ARGS=${JVM_ARGS}
fi

if [ ! -z "${MAX_MEM}" ]; then
    if [ ! -z "${USED_JVM_ARGS}" ]; then
        USED_JVM_ARGS="${USED_JVM_ARGS} -Xmx${MAX_MEM}"
    else
        USED_JVM_ARGS="-Xmx${MAX_MEM}"
    fi
fi

if [ ! -z "${MIN_MEM}" ]; then
    if [ ! -z "${USED_JVM_ARGS}" ]; then
        USED_JVM_ARGS="${USED_JVM_ARGS} -Xms${MIN_MEM}"
    else
        USED_JVM_ARGS="-Xms${MIN_MEM}"
    fi
fi

if [ -z "${USED_JVM_ARGS}" ]; then
    echo -e "Running 'java -jar /spigot-${1}.jar nogui ${SPIGOT_ARGS}'"
    java -jar /spigot-${1}.jar nogui ${SPIGOT_ARGS}
else
    echo -e "Running 'java ${USED_JVM_ARGS} -jar /spigot-${1}.jar nogui ${SPIGOT_ARGS}'"
    java ${USED_JVM_ARGS} -jar /spigot-${1}.jar nogui ${SPIGOT_ARGS}
fi