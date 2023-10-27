#!/bin/bash

function kp-build-in-docker() {
  sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories
  apk --no-cache add bash iptables ip6tables conntrack-tools ipvsadm gcc ipset ipset-dev iptables iptables-dev libnfnetlink libnfnetlink-dev libnl3 libnl3-dev libnftnl-dev make musl-dev openssl openssl-dev autoconf automake git
}

function kp-build() {
  ./autogen.sh
  ./configure --prefix=$PWD/target --enable-checker-debug
  make
  md5sum ./bin/keepalived
}

function kp-init-run() (
  mkdir -p ./run
  cp ./actions/live.conf ./run
  cp ./actions/check.sh ./run
  cp ./actions/rip_check.sh ./run
)
function kp-loop() (
  make
  md5sum ./bin/keepalived
)

function kp-note() (
  # sudo iptables -t filter --append OUTPUT --dst 192.168.131.63 -j DROP ;sudo iptables-save|grep DROP
  # sudo ipvsadm -ln
  # sudo iptables -t filter -D OUTPUT --dst 192.168.131.63 -j DROP ;sudo iptables-save|grep DROP
  return
)

function kp-test() (
  sudo ../bin/keepalived -n -l -D -G -f ./live.conf -r ./vrrp.pid -p ./kp.pid -c ./kp.check.pid 2>&1 | tee ./kp.log
)
