# Yocto meta-aws Build Container

## Build the Container

```bash
podman build -t yocto-meta-aws -f Containerfile .
```

For different OS versions:
```bash
podman build -t yocto-meta-aws-ubuntu2204 --build-arg BASE_IMAGE=ubuntu:22.04 -f Containerfile .
podman build -t yocto-meta-aws-ubuntu2404 --build-arg BASE_IMAGE=ubuntu:24.04 -f Containerfile .
podman build -t yocto-meta-aws-ubuntu2510 --build-arg BASE_IMAGE=ubuntu:25.10 -f Containerfile .
```

## Run Build Environment

```bash
./run.sh ubuntu2404 yocto-meta-aws
```

## Build aws-sdk-cpp

Inside the container:

```bash
cd /workspace/bitbake-builds/poky-without-meta-aws-poky-with-sstate-distro_poky-altcfg-machine_qemux86-64/build
. init-build-env
bitbake aws-sdk-cpp
```

## Modify Patches

To reproduce issues by enabling/disabling patches:

```bash
cd /workspace/meta-aws/recipes-sdk/aws-sdk-cpp
# Edit the .bb file to comment/uncomment patches
# Then rebuild:
cd /workspace/bitbake-builds/poky-without-meta-aws-poky-with-sstate-distro_poky-altcfg-machine_qemux86-64/build
. init-build-env
bitbake -c cleansstate aws-sdk-cpp
bitbake aws-sdk-cpp
```

## Configuration

- Base: Ubuntu 24.04
- Machine: qemux86-64
- Distro: poky-altcfg
- Meta-aws: master-next branch
- Sstate: Enabled (CDN mirror)
- Build directory: `/workspace/bitbake-builds/poky-without-meta-aws-poky-with-sstate-distro_poky-altcfg-machine_qemux86-64/build`
