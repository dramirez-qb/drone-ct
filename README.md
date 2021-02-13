# drone-ct [WIP] [![Build Status](https://drone.dxas90.xyz/api/badges/dxas90/drone-ct/status.svg)](https://drone.dxas90.xyz/dxas90/drone-ct)

This [Drone](https://drone.io/) plugin allows you to use `ct` without messing around with the authentication.

## Usage

```yaml
# drone 1.0 syntax
kind: pipeline
name: deploy

steps:
  - name: deploy
    image: dxas90/drone-ct
    environment:
      KUBE_CONFIG:
        from_secret: kube_config
    commands:
      - /bin/kubectl create -f job_foo.yaml
      - /bin/kubectl wait --for=condition=complete -f job_foo.yaml
```

## How to get the credentials

First, you need to have a service account with **proper privileges** and **service-account-token**:

```bash
cat ~/.kube/config | base64 -w0 > config-serialized
```

### Special thanks

Inspired by:
- [drone-kubectl](https://github.com/dxas90/drone-kubectl)
