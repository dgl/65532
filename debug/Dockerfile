ARG BASE=
FROM ${BASE}
SHELL ["/bin/bash", "-c"]
USER root
RUN <<EOF
set -ex

apt-get -y update
# Some of these may need root, but useful to have around anyway as a user can
# easily run this container as root if permissions allow.
apt-get install -y --no-install-recommends tcpdump net-tools iputils-ping iputils-tracepath traceroute curl wget bind9-dnsutils skopeo openssh-client strace ltrace gdb bash-completion man less vim-tiny bpfcc-tools bpftrace psmisc procps htop btop iproute2 numactl

# Because Ubuntu want to push snap on you they don't ship kubectl, sigh. Debian win.
# Using the packaged version sets up bash completion for us, much nicer.
. /etc/os-release
if [[ ${ID} = debian ]]; then
  apt-get install -y kubernetes-client
fi

apt-get clean
rm -rf /var/lib/apt/lists/*
EOF
USER 65532
