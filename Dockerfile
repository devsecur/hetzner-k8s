FROM alpine

# Set environment variables
ENV GOPATH="/opt/go/" \
    PATH="/usr/local/go/bin:${PATH}:/opt/go/bin" \
    KUBECONFIG="/etc/kube/config"

# Install environment
RUN apk add --update ca-certificates \
 && apk add --update -t deps curl \
 && curl -L https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
 && chmod +x /usr/local/bin/kubectl \
 && wget https://get.helm.sh/helm-v2.14.1-linux-amd64.tar.gz \
 && tar xvf helm-v2.14.1-linux-amd64.tar.gz \
 && mv linux-amd64/helm /usr/local/bin/helm \
 && apk add --update go git musl-dev bash-completion bash gawk sed grep bc coreutils \
 && go get -u github.com/hetznercloud/cli/cmd/hcloud \
 && go get -u github.com/xetys/hetzner-kube \
 && echo "source usr/share/bash-completion/bash_completion" >> /root/.bashrc \
 && echo "source <(kubectl completion bash)" >> /root/.bashrc \
 && echo "source <(hcloud completion bash)" >> /root/.bashrc \
 && apk del --purge deps \
 && rm /var/cache/apk/*

# Insert start script for HCLOUD_TOKEN
COPY docker-entrypoint.sh .
ENTRYPOINT ["./docker-entrypoint.sh"]
