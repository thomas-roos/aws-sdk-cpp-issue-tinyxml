#!/bin/bash

OS=${1:-ubuntu2404}
IMAGE=${2:-yocto-meta-aws}
MACHINE=${3:-qemux86-64}

# Add localhost/ prefix if not present
if [[ ! "$IMAGE" =~ ^localhost/ ]]; then
  IMAGE="localhost/$IMAGE"
fi

mkdir -p common-data/{downloads,sstate-cache} data-${OS}-${MACHINE}/tmp

podman run -it \
  --userns=keep-id \
  -v $(pwd)/common-data/downloads:/workspace/bitbake-builds/poky-without-meta-aws-poky-with-sstate-distro_poky-altcfg-machine_${MACHINE}/build/downloads:Z \
  -v $(pwd)/common-data/sstate-cache:/workspace/bitbake-builds/poky-without-meta-aws-poky-with-sstate-distro_poky-altcfg-machine_${MACHINE}/build/sstate-cache:Z \
  -v $(pwd)/data-${OS}-${MACHINE}/tmp:/workspace/bitbake-builds/poky-without-meta-aws-poky-with-sstate-distro_poky-altcfg-machine_${MACHINE}/build/tmp:Z \
  ${IMAGE}
