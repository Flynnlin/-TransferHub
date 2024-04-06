# 使用一个轻量的基础镜像，比如Alpine Linux
FROM alpine:latest

# 安装所需的软件包
RUN apk --no-cache add openssh-server python3

# 在容器内创建一个目录用于文件传输
RUN mkdir -p /transfer

# 设置 SSH 服务的配置并生成密钥
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    ssh-keygen -A

# 暴露服务端口
EXPOSE 80 22

# 复制启动脚本到容器中
COPY start_services.sh /start_services.sh

# 设置可执行权限并启动容器时运行的命令
RUN chmod +x /start_services.sh
CMD ["/start_services.sh"]
