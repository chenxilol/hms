# 使用官方的 Golang 镜像作为基础镜像
FROM golang:latest AS builder

# 设置工作目录
WORKDIR /app
# 复制项目文件到工作目录
COPY . .
# 编译应用
RUN go build -o hrms_app main.go

# 使用轻量的 alpine 镜像作为最终的基础镜像
FROM alpine:latest

# 设置工作目录
WORKDIR /app
# 从构建镜像中复制编译好的二进制文件到最终镜像
COPY --from=builder /app/hrms_app .
# 复制前端模板文件
COPY views /app/views
# 暴露应用的端口
EXPOSE 8888
# 运行应用
CMD ["./hrms_app"]
