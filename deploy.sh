#!/usr/bin/env bash

helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/
helm install coreos/prometheus-operator --name prometheus-operator  --namespace monitoring

go="/root/go"

mkdir -p $go
# Install golang and hey
export "GOPATH=$go" >> /etc/environment
echo "$GOPATH" >> /etc/environment
add-apt-repository ppa:gophers/archive -y && apt-get update -y && apt-get install golang-1.10-go -y
export "PATH=$GOPATH/bin:/usr/lib/go-1.10/bin:$PATH" 
echo "$PATH" >> /etc/environment
go get -u github.com/rakyll/hey

kubectl create -f ./metrics-server
helm install coreos/kube-prometheus --name kube-prometheus --namespace monitoring -f kube-prometheus.yml
kubectl create -f ./predicted-cpu-usage
kubectl create -f custom-metrics.yml

git clone https://github.com/stefanprodan/k8s-prom-hpa.git && cd k8s-prom-hpa && kubectl create -f ./podinfo/podinfo-svc.yaml,./podinfo/podinfo-dep.yaml && kubectl create -f ./podinfo/podinfo-hpa.yaml
