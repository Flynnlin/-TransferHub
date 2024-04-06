#!/bin/sh

# 启动SSH服务
/usr/sbin/sshd

# 启动Web服务
cd /transfer
python3 -m http.server 80
