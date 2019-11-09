# hetzner-k8s
Dockerfile for effective construction and maintenance of a k8s cluster on hetzner

## Prerquists

* Create token in [hetzner console](https://console.hetzner.cloud/)
* Make sure the [kube config](https://kubernetes.io/docs/tasks/access-application-cluster/access-cluster/#accessing-for-the-first-time-with-kubectl) is in your home directory in .kube or change path in docker-compose file. If you don't have a cluster or config yet, you can use [hetzner-kube](https://github.com/xetys/hetzner-kube) in this image to create one.
* Export HCLOUD_TOKEN:
```
export HCLOUD_TOKEN=<token>
docker-compose run client bash
```


## Create k8s on hetzner

```
hetzner-kube context add k8s
ssh-keygen -t rsa
hetzner-kube ssh-key add --name k8s
hetzner-kube cluster create --name k8s --ssh-key k8s --master-count 1 --worker-count 1
hetzner-kube cluster kubeconfig k8s
```

* Create Domains at https://my.freenom.com/domains.php pointing on master IP
* Change IPs and Domains in ingress-nginx.yaml and ingress.yaml

## Install Ingress Controler for DNS and IP support

```
kubectl apply -f mandatory/ingress.yaml
```

## Install Cert-Manager for letsencrypt

```
kubectl apply -f https://raw.githubusercontent.com/jetstack/cert-manager/master/deploy/manifests/00-crds.yaml
kubectl create namespace cert-manager
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v0.8.1/cert-manager.yaml
kubectl apply -f prod_issuer.yaml
```

## Install Application

```
kubectl apply -f app.yaml
```

## Install Ingress

```
kubectl apply -f ingress.yaml
```

## Install system tools

### Spekt8

```
kubectl apply -f https://raw.githubusercontent.com/spekt8/spekt8/master/fabric8-rbac.yaml
kubectl apply -f spekt8-deployment.yaml
kubectl port-forward deployment/spekt8 3000:3000
```
