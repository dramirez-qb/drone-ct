Forked and built with the latest kubectl. 

# drone-kubectl

This [Drone](https://drone.io/) plugin allows you to use `kubectl` without messing around with the authentication.

## Usage

```yaml
# drone 1.0 syntax
kind: pipeline
name: deploy

steps:
  - name: deploy
    image: dxas90/drone-kubectl
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
- [drone-kubernetes](https://github.com/honestbee/drone-kubernetes)
- [drone-kubectl](https://github.com/sinlead/drone-kubectl)
