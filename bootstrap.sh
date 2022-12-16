#!/bin/bash
# Cert-manager
kubectl create namespace cert-manager
helm repo add jetstack https://charts.jetstack.io
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.9.1 \
  --set installCRDs=true \
  --set startupapicheck.timeout=5m

# ArgoCD
kubectl create namespace argocd
helm repo add argo https://argoproj.github.io/argo-helm
helm install argocd argo/argo-cd -n argocd

# Jenkins
kubectl create namespace jenkins
helm repo add jenkins https://raw.githubusercontent.com/jenkinsci/kubernetes-operator/master/chart
# helm install jenkins jenkins/jenkins-operator -n jenkins --set jenkins.namespace=jenkins
kubectl apply -f ./jenkins-home-pv.yaml -n jenkins
kubectl apply -f ./jenkins-home-pvc.yaml -n jenkins
helm upgrade --install jenkins jenkins/jenkins-operator -n jenkins -f ./jenkins-operator-values.yaml

# Grafana + Loki
kubectl create namespace grafana
helm repo add grafana https://grafana.github.io/helm-charts
helm install loki grafana/loki-distributed -n grafana
helm install loki-grafana grafana/grafana -n grafana

# Prometheus
kubectl create namespace prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack --set grafana.enabled=false -n prometheus

# Jaeger
kubectl create namespace jaeger
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
helm install jaeger jaegertracing/jaeger-operator --namespace jaeger --values jaeger-operator-values.yaml
