# traccar-init

Docker container meant to be run as an init container for [traccar](https://hub.docker.com/r/traccar/traccar) pod. It constructs a traccar.xml configuration file from the mounted configmaps/secrets.

## Usage

```yaml
apiVersion: apps/v1
kind: Deployment
# <snip>
spec:
  volumes:
    - name: traccar-conf-dir
      emptyDir: {}
    - name: traccar-conf-0
      configMap:
        name: traccar
  # <snip>
  initContainers:
    - name: generate-config
      image: ghcr.io/roosmaa/multus-init:main
      volumeMounts:
        - name: traccar-conf-dir
          mountPath: /opt/traccar/conf
        - name: traccar-conf-0
          mountPath: /opt/traccar/conf-0
          readOnly: true
  # <snip>

---
apiVersion: v1
kind: ConfigMap
# <snip>
data:
  # see https://www.traccar.org/configuration-file/
  database.driver: org.postgresql.Driver
  notificator.types: web,mail,traccar

```
