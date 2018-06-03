#!/usr/bin/env bash
kubectl delete -f ./podinfo
kubectl delete -f custom-metrics.yml
kubectl delete -f ./predicted-cpu-usage
helm delete --purge kube-prometheus
kubectl delete -f ./metrics-server
