#!/usr/bin/env bash

helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/
helm install coreos/prometheus-operator --name prometheus-operator  --namespace monitoring

mkdir -p /root/go

# Install golang and hey
GOPATH="/root/go"
echo "GOPATH=$GOPATH" >> /etc/environment
add-apt-repository ppa:gophers/archive -y && apt-get update -y && apt-get install golang-1.10-go -y
echo "PATH=$GOPATH/bin:/usr/lib/go-1.10/bin:$PATH" >> /etc/environment
go get -u github.com/rakyll/hey

kubectl create -f ./metrics-server
helm install coreos/prometheus --name grafana-prometheus --namespace monitoring -f prometheus.yml 
helm install coreos/grafana --name grafana --namespace monitoring --set service.type=NodePort
helm install coreos/exporter-kubelets --name exporter-kubelets --namespace monitoring
helm install coreos/exporter-kube-state --name exporter-kube-state --namespace monitoring

git clone https://github.com/stefanprodan/k8s-prom-hpa.git && cd k8s-prom-hpa && kubectl create -f ./podinfo/podinfo-svc.yaml,./podinfo/podinfo-dep.yaml && kubectl create -f ./podinfo/podinfo-hpa.yaml


#helm install coreos/kube-prometheus --name kube-prometheus --namespace monitoring -f kube-prometheus.yml

