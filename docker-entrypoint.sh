#!/bin/bash

set -e

if [ -n "${HCLOUD_TOKEN}" ]; then
  hetzner-kube context add my-cluster --token $HCLOUD_TOKEN;
  echo "";
else
  echo "HCLOUD_TOKEN environment variable missing"
fi

exec "$@"
