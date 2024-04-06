# 文件传输服务

该 Docker 容器提供了一个简单的文件传输服务，同时提供了 Web 服务和 SSH 服务。

## 构建 Docker 容器

```bash
docker build -t transferhub .
```

## 启动容器

要启动容器，执行以下命令：

```bash
docker run -e SSH_USER=transfer -e SSH_PASSWORD=passwd -p 7022:22 -p 7080:80 -d --name file_transfer_container transferhub

```

此命令将在后台启动名为 "file_transfer_container" 的容器，并将容器的 80 端口映射到主机的 7080 端口，22 端口映射到主机的 7022 端口。

## 使用文件传输服务

### 通过 Web 服务传输文件

通过浏览器访问以下 URL 来上传或下载文件：

```
http://localhost:7080/
```

### 通过 SSH 服务传输文件

使用 SSH 客户端连接到容器，并使用提供的用户名和密码进行身份验证：

```bash
ssh transfer_user@localhost -p 7022
```

提供的默认用户名和密码是：

```
用户名: transfer_user
密码: transfer_password
```

连接成功后，您可以在容器中自由传输文件。
