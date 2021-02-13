#!/bin/bash

#Create project variable called CI_DEBUG and assing it "true" (case insensitive) to enable bash debug mode or "verbose" for verbose debug mode
if [ "${CI_DEBUG,,}" == "true" ]; then set -x ;elif [ "${CI_DEBUG,,}" == "verbose" ]; then set -xv; fi

set -o errexit
set -o nounset
set -o pipefail

install_kind() {
    echo 'Installing kind...'
    curl -sSLo "/usr/local/bin/kind" "https://github.com/kubernetes-sigs/kind/releases/download/${DEFAULT_KIND_VERSION}/kind-linux-amd64"
    chmod +x "/usr/local/bin/kind"
}

install_kubectl() {
    echo 'Installing kubectl...'

    curl -sSLo "/usr/local/bin/kubectl" "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
    chmod +x "/usr/local/bin/kubectl"
}

install_chart_testing() {

    local arch
    arch=$(uname -m)
    local cache_dir="/tmp/ct"
    mkdir -p "$cache_dir"

    echo "Installing chart-testing..."
    curl -sSLo ct.tar.gz "https://github.com/helm/chart-testing/releases/download/${DEFAULT_CHART_TESTING_VERSION}/chart-testing_${DEFAULT_CHART_TESTING_VERSION#v}_linux_amd64.tar.gz"
    tar -xzf ct.tar.gz -C "$cache_dir"
    rm -f ct.tar.gz
    mv "$cache_dir/ct" /usr/local/bin/ct
    mv "$cache_dir/etc" /etc/ct

    echo 'Installing yamllint...'
    pip3 install yamllint==1.25.0

    echo 'Installing Yamale...'
    pip3 install yamale==3.0.4

    ct version
}

if [ ! -f "$(command -v kind)" ]; then
    install_kind
fi

if [ ! -f "$(command -v kubectl)" ]; then
    install_kubectl
fi

if [ ! -f "$(command -v ct)" ]; then
    install_chart_testing
fi
