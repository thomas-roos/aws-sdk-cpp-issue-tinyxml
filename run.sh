#!/bin/bash

OS=${1:-ubuntu2404}
IMAGE=${2:-yocto-meta-aws}

# Add localhost/ prefix if not present
if [[ ! "$IMAGE" =~ ^localhost/ ]]; then
  IMAGE="localhost/$IMAGE"
fi

mkdir -p common-data/{downloads,sstate-cache} data-${OS}/tmp

podman run -it \
  --userns=keep-id \
  -v $(pwd)/common-data/downloads:/workspace/bitbake-builds/poky-without-meta-aws-poky-with-sstate-distro_poky-altcfg-machine_qemux86-64/build/downloads:Z \
  -v $(pwd)/common-data/sstate-cache:/workspace/bitbake-builds/poky-without-meta-aws-poky-with-sstate-distro_poky-altcfg-machine_qemux86-64/build/sstate-cache:Z \
  -v $(pwd)/data-${OS}/tmp:/workspace/bitbake-builds/poky-without-meta-aws-poky-with-sstate-distro_poky-altcfg-machine_qemux86-64/build/tmp:Z \
  ${IMAGE}
