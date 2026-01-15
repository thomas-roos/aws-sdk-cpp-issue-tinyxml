ARG BASE_IMAGE=ubuntu:24.04
FROM ${BASE_IMAGE}

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get update && apt-get install -y \
    gawk wget git diffstat unzip texinfo gcc build-essential vim \
    chrpath socat cpio python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping python3-git python3-jinja2 \
    python3-subunit python3-websockets \
    zstd liblz4-1 file locales libacl1 curl \
    && rm -rf /var/lib/apt/lists/* \
    && locale-gen en_US.UTF-8

RUN curl -fsSL https://github.com/kanavin/bitbake/archive/akanavin/bitbake-setup.tar.gz | tar -xz \
    && cd bitbake-akanavin-bitbake-setup \
    && python3 bin/bitbake-setup

WORKDIR /workspace

ENV PATH="/bitbake-akanavin-bitbake-setup/bin:${PATH}"

RUN git clone -b master-next https://github.com/aws4embeddedlinux/meta-aws.git \
    && bitbake-setup --setting default top-dir-prefix /workspace init --non-interactive /workspace/meta-aws/.github/workflows/poky-without-meta-aws.conf.json poky-with-sstate distro/poky-altcfg machine/qemux86-64

ENV LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

RUN useradd -m -s /bin/bash builder \
    && chown -R builder:builder /workspace

USER builder

RUN git config --global user.email "test@example.com" \
    && git config --global user.name "Test User"

CMD ["/bin/bash"]
