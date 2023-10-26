#!/bin/bash

function kp-build-in-docker() {
  sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
  apk --no-cache add bash iptables ip6tables conntrack-tools ipvsadm gcc ipset ipset-dev iptables iptables-dev libnfnetlink libnfnetlink-dev libnl3 libnl3-dev libnftnl-dev make musl-dev openssl openssl-dev autoconf automake git
}

function kp-build() {
  ./autogen.sh
  ./configure --prefix=$PWD/target
  make
}

function kp-loop() {
  make
}
