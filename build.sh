#!/bin/bash

set -e

sudo docker build \
    -t minecraft-java-client \
    .
