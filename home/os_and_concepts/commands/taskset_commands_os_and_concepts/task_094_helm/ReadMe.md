# helm

- [helm](https://helm.sh/docs/helm/)

## Examples

- To add a new Helm chart repository to your Helm installation. A Helm chart repository is a location where packaged charts can be stored and shared

```bash
$ helm repo add bitnami https://charts.bitnami.com/bitnami
.
```

- To update your local Helm chart repository cache after you add a new Helm chart repository to your Helm installation

```bash
$ helm repo update
.
```

- The `helm pull` command is used to download a Helm chart from a repository to your local machine.

```bash
$ helm pull bitnami/postgresql                    
$ ls
postgresql-12.6.0.tgz
$ tar -xvf postgresql-12.6.0.tgz
$ ls
postgresql            postgresql-12.6.0.tgz
$ rm -rf postgresql-12.6.0.tgz
```

- The `helm template` command is used to render the template files locally to a file or stdout. It is useful for testing the template rendering and syntax.

```bash
# After helm pull bitnami/postgresql as done above
# - Download this file [keycloak-db-values.yaml](https://github.com/codecentric/helm-charts/blob/master/charts/keycloakx/examples/postgresql/keycloak-db-values.yaml) to keycloak-db-values.yaml file

$ cat keycloak-db-values.yaml
# See https://github.com/bitnami/charts/tree/master/bitnami/postgresql
# See https://github.com/codecentric/helm-charts/blob/master/charts/keycloakx/examples/postgresql/keycloak-db-values.yaml
global:
  postgresql:
    auth:
      username: dbusername
      password: dbpassword
      database: keycloak

# # https://github.com/codecentric/helm-charts/tree/master/charts/keycloakx/examples/postgresql
$ tree -L 3                     
.
├── keycloak-db-values.yaml
└── postgresql
    ├── Chart.lock
    ├── Chart.yaml
    ├── README.md
    ├── charts
    │   └── common
    ├── templates
    │   ├── NOTES.txt
    │   ├── _helpers.tpl
    │   ├── extra-list.yaml
    │   ├── networkpolicy-egress.yaml
    │   ├── primary
    │   ├── prometheusrule.yaml
    │   ├── psp.yaml
    │   ├── read
    │   ├── role.yaml
    │   ├── rolebinding.yaml
    │   ├── secrets.yaml
    │   ├── serviceaccount.yaml
    │   └── tls-secrets.yaml
    ├── values.schema.json
    └── values.yaml

$ helm template keycloak-db postgresql \
--namespace keycloak \
--create-namespace \
--values ./keycloak-db-values.yaml \
> keycloak-db-manifest-vendor.yaml
```

- To list all the Helm releases

```bash
$ helm list --all-namespaces
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                   APP VERSION
keycloak-db     keycloak        1               2023-06-30 19:03:37.623113 +0530 IST    deployed        postgresql-12.6.0       15.3.0
```

- To uninstall a Helm release

```bash
$ helm uninstall keycloak-db --namespace keycloak
.
```

