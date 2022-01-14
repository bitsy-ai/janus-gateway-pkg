#!/bin/bash

docker buildx build --platform=aarch64 -f arm64-deb.Dockerfile .