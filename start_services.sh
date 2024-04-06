#!/bin/sh

# 创建新的 SSH 用户并设置密码
SSH_USER=${SSH_USER:-transfer_user}
SSH_PASSWORD=${SSH_PASSWORD:-transfer_password}
adduser -D -h /transfer ${SSH_USER}
echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd

# 启动SSH服务
/usr/sbin/sshd

# 启动Web服务
cd /transfer
python3 -m http.server 80
