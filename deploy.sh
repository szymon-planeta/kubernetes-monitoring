#!/usr/bin/env bash

helm repo add coreos https://s3-eu-west-1.amazonaws.com/coreos-charts/stable/
helm install coreos/prometheus-operator --name prometheus-operator
helm install coreos/exporter-kubelets --name exporter-kubelets --set https=false
helm install coreos/prometheus --name prometheus -f prometheus.yml
helm install coreos/grafana --name grafana --set service.type=NodePort
