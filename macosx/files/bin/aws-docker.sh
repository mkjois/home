#!/usr/bin/env bash

exec docker run --rm -i \
    -v ${HOME}/.aws:/root/.aws:ro \
    -v ${HOME}/.kube:/root/.kube \
    -v "$(pwd):/aws" \
    dockerhub.qcinternal.io/amazon/aws-cli "$@"
