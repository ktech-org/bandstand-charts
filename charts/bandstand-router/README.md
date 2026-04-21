# Bandstand router

## Global values

| Key                                   | Type   | Default | Description                                          |
|---------------------------------------|--------|---------|------------------------------------------------------|
| global.env                            | string |         | The environment, either test, preprod or prod        |
| global.releaseTags.backstageComponent | string |         | Backstage component name for service catalog         |
| global.releaseTags.backstageOwner     | string |         | Backstage owner (team) for service catalog           |
| global.releaseTags.backstageSystem    | string |         | Backstage system for service catalog (optional)      |

## Values

| Key                           | Type   | Default | Description                                                                                                                                                                                                                       |
|-------------------------------|--------|---------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| additionalDomains             | list   | `[]`         | A list of additional domains for the router. A TLS certificate will be created for each via cert-manager.                                                                                                                         |
| ingress.annotations           | object | `{}`         | Additional annotations to apply to the ingress object                                                                                                                                                                             |
| ingress.domain                | string |              | **Required.** Primary ingress domain (e.g. `ktech.com`)                                                                                                                                                                          |
| ingress.enabled               | bool   |              | True if the router has an ingress                                                                                                                                                                                                  |
| ingress.subdomain             | string |              | **Required.** The subdomain for this router. The full hostname will be `{subdomain}.{env}.{domain}`                                                                                                                               |
| ingress.visibility            | string |              | Whether the ingress is externally visible, either cluster, private or public                                                                                                                                                      |
| ingress.defaultBackend        | string |              | The name of the existing service to route `/` traffic to                                                                                                                                                                          |
| ingress.additionalPaths       | list   |              | Additional path rules to apply to the ingress host, see [here](https://kubernetes.io/docs/concepts/services-networking/ingress/#the-ingress-resource) and [here](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.19/#httpingresspath-v1-networking-k8s-io) |
| ingress.authenticationBackend | string |              | Shorthand to proxy `/authentication` path to the specified backend service. Alternative to using `ingress.additionalPaths`.                                                                                                       |
