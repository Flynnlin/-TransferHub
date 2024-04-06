# 使用一个轻量的基础镜像，比如Alpine Linux
FROM alpine:latest

# 安装所需的软件包
RUN apk --no-cache add openssh-server python3

# 创建一个新的 SSH 用户，并设置密码
ARG SSH_USER=transfer_user
ARG SSH_PASSWORD=transfer_password
RUN adduser -D ${SSH_USER} && echo "${SSH_USER}:${SSH_PASSWORD}" | chpasswd

# 在容器内创建一个目录用于文件传输
RUN mkdir -p /transfer
# 设置 transfer_user 的 HOME 目录为 /transfer
RUN sed -i "s|^${SSH_USER}:[^:]*:\([^:]*\):[^:]*:\([^:]*\):[^:]*:|${SSH_USER}:\1:/transfer:\2::|g" /etc/passwd

# 设置 SSH 服务的配置
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    ssh-keygen -A

# 暴露服务端口
EXPOSE 80 22

# 复制启动脚本到容器中
COPY start_services.sh /start_services.sh

# 设置可执行权限
RUN chmod +x /start_services.sh

# 启动容器时运行的命令
CMD ["/start_services.sh"]
