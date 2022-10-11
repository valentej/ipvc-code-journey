# Instructions
Here we've placed the commands you'll need to deploy the full stack, and to get the admin credentials and access them through localhost. You can automate all of this with something similar to our basic [bootstrap script](./bootstrap.sh).
# Cert-manager
## Installation
```
kubectl create namespace cert-manager
helm repo add jetstack https://charts.jetstack.io
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.9.1 \
  --set installCRDs=true \
  --set startupapicheck.timeout=5m
```
# ArgoCD
## Installation
```
kubectl create namespace argocd
helm repo add argo https://argoproj.github.io/argo-helm
helm install argocd argo/argo-cd -n argocd
```
## Credentials
```
admin
kubectl get secret -n argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```
## Access locally
```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
# Jenkins
## Installation
```
kubectl create namespace jenkins
helm repo add jenkins https://raw.githubusercontent.com/jenkinsci/kubernetes-operator/master/chart
helm install jenkins jenkins/jenkins-operator -n jenkins --set jenkins.namespace=jenkins
```
## Credentials
```
kubectl get secret -n jenkins jenkins-operator-credentials-jenkins -o jsonpath="{.data.user}" | base64 -d; echo
kubectl get secret -n jenkins jenkins-operator-credentials-jenkins -o jsonpath="{.data.password}" | base64 -d; echo
```
## Access locally
```
kubectl port-forward svc/jenkins-operator-http-jenkins -n jenkins 8081:8080
```
# Grafana + Loki
## Installation
```
kubectl create namespace grafana
helm repo add grafana https://grafana.github.io/helm-charts
helm install loki grafana/loki-distributed -n grafana
helm install loki-grafana grafana/grafana -n grafana
```
## Credentials (Grafana)
```
admin
kubectl get secret -n grafana loki-grafana -o jsonpath="{.data.admin-password}" | base64 -d; echo
```
## Access locally (Grafana)
```
kubectl port-forward -n grafana svc/loki-grafana 8082:80
```
# Prometheus
## Installation
```
kubectl create namespace prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install prometheus prometheus-community/kube-prometheus-stack --set grafana.enabled=false -n prometheus
```
# Jaeger
## Installation
```
kubectl create namespace jaeger
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts
helm install jaeger jaegertracing/jaeger-operator --namespace jaeger --values jaeger-operator-values.yaml
```
## Running locally 
```
kubectl port-forward -n jaeger svc/jaeger-jaeger-operator-jaeger-query 8083:16686
```