#!/bin/sh

# 修改配置
cp config/k8s/containerd/config.toml /etc/containerd/config.toml


# 列出需要镜像
kubeadm config images list --kubernetes-version v1.25.9


# 更改标签
docker tag registry.aliyuncs.com/google_containers/kube-apiserver:v1.25.9 registry.k8s.io/kube-apiserver:v1.25.9
docker tag registry.aliyuncs.com/google_containers/kube-controller-manager:v1.25.9 registry.k8s.io/kube-controller-manager:v1.25.9
docker tag registry.aliyuncs.com/google_containers/kube-scheduler:v1.25.9 registry.k8s.io/kube-scheduler:v1.25.9
docker tag registry.aliyuncs.com/google_containers/kube-proxy:v1.25.9 registry.k8s.io/kube-proxy:v1.25.9
docker tag registry.aliyuncs.com/google_containers/etcd:3.5.6-0 registry.k8s.io/etcd:3.5.6-0
docker tag registry.aliyuncs.com/google_containers/pause:3.6 registry.k8s.io/pause:3.6
docker tag registry.aliyuncs.com/google_containers/coredns:v1.9.3 registry.k8s.io/coredns/coredns:v1.9.3

docker rmi registry.aliyuncs.com/google_containers/kube-apiserver:v1.25.9
docker rmi registry.aliyuncs.com/google_containers/kube-controller-manager:v1.25.9
docker rmi registry.aliyuncs.com/google_containers/kube-scheduler:v1.25.9
docker rmi registry.aliyuncs.com/google_containers/kube-proxy:v1.25.9
docker rmi registry.aliyuncs.com/google_containers/etcd:3.5.6-0
docker rmi registry.aliyuncs.com/google_containers/pause:3.6
docker rmi registry.aliyuncs.com/google_containers/coredns:v1.9.3

# 导入 cri
docker save registry.k8s.io/pause:3.6 -o pause_3_6.tar
ctr -n k8s.io images import pause_3_6.tar
ctr -n k8s.io images list | grep pause


  



