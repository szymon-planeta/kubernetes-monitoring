#!/usr/bin/env bash

helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/
helm install coreos/prometheus-operator --name prometheus-operator  --namespace monitoring

#helm install coreos/exporter-kubelets --name exporter-kubelets
#helm install coreos/prometheus --name prometheus -f prometheus.yml
#helm install coreos/grafana --name grafana --set service.type=NodePort
helm install coreos/kube-prometheus --name kube-prometheus --namespace monitoring

#kubectl create -f ./metrics-server
