#!/bin/bash

sudo apt-get update
sudo apt-get install -y docker.io
sudo chmod 666 /var/run/docker.sock

docker run ghcr.io/arriven/db1000n