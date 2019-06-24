# hetzner-k8s
Dockerfile for effective construction and maintenance of a k8s cluster on hetzner

## HowTo

* Create token in [hetzner console](https://console.hetzner.cloud/)
* Make sure the [kube config](https://kubernetes.io/docs/tasks/access-application-cluster/access-cluster/#accessing-for-the-first-time-with-kubectl) is in your home directory in .kube or change path in docker-compose file. If you don't have a cluster or config yet, you can use [hetzner-kube](https://github.com/xetys/hetzner-kube) in this image to create one.

```
export HCLOUD_TOKEN=<token>
docker-compose run client bash
```
