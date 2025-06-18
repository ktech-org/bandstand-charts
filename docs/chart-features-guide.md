# Bandstand Charts Features Guide

This guide explains the features available in the Bandstand Helm charts, with notes on which charts support each feature and how to use them.

## Common Features

- **Image configuration**: Set the container image, tag, and pull policy for your workloads. Supported by all charts.
  - Feature BDD tests:
    - Given a chart, when a user sets a custom image, then the deployed pod uses the specified image.
    - Given a chart, when a user sets a custom image tag, then the deployed pod uses the specified tag.
    - Given a chart, when a user sets a custom image pull policy, then the pod uses the specified pull policy.

- **Resource requests and limits**: Configure CPU, memory, and ephemeral storage for containers.
  - Feature BDD tests:
    - Given a chart, when a user sets CPU requests, then the pod has the correct CPU request.
    - Given a chart, when a user sets CPU limits, then the pod has the correct CPU limit.
    - Given a chart, when a user sets memory requests, then the pod has the correct memory request.
    - Given a chart, when a user sets memory limits, then the pod has the correct memory limit.
    - Given a chart, when a user sets ephemeral storage requests, then the pod has the correct ephemeral storage request.

- **Environment variables**: Inject environment variables via `additionalEnvVars`, `environmentEnvVars`, or `commonEnv`.
  - Feature BDD tests:
    - Given a chart, when a user sets an environment variable, then the pod contains the variable with the correct value.
    - Given a chart, when a user sets environment variables via a ConfigMap, then the pod contains those variables.

- **Secrets and ConfigMaps**: Mount secrets and config maps as environment variables or files using `envFrom`, `secrets`, and related fields.
  - Feature BDD tests:
    - Given a chart, when a user references a secret, then the pod contains the secret as an environment variable.
    - Given a chart, when a user references a ConfigMap, then the pod contains the ConfigMap as an environment variable.
    - Given a chart, when a user mounts a secret as a file, then the file exists in the pod at the specified path.

- **Volumes**: Support for persistent and ephemeral volumes (not all charts). S3 volumes are supported in cron-job.
  - Feature BDD tests:
    - Given a chart, when a user configures a persistent volume, then the pod mounts the volume at the specified path.
    - Given a chart, when a user configures an ephemeral volume, then the pod mounts the volume at the specified path.
    - Given a cron-job chart, when a user configures an S3 volume, then the pod mounts the S3 volume at the specified path.

- **Service exposure**: Expose services via Kubernetes Service objects (web-service, headless-service, confluent-connect).
  - Feature BDD tests:
    - Given a chart, when service exposure is enabled, then a Service resource is created.
    - Given a chart, when a user sets a service port, then the Service exposes the correct port.

- **Ingress support**: Expose services via ingress (web-service, confluent-connect).
  - Feature BDD tests:
    - Given a chart, when ingress is enabled, then an Ingress resource is created.
    - Given a chart, when a user sets a custom domain, then the Ingress uses the specified domain.
    - Given a chart, when a user sets a custom path, then the Ingress uses the specified path.

- **Scaling**: Horizontal Pod Autoscaler (HPA) and advanced scaling options (web-service, headless-service, confluent-connect, triggered-job).
  - Feature BDD tests:
    - Given a chart, when HPA is enabled, then the deployment scales based on CPU utilization.
    - Given a chart, when advanced scaling is enabled, then the deployment scales according to the custom scaler configuration.

- **AZ balancing**: Distribute replicas across availability zones (web-service, headless-service).
  - Feature BDD tests:
    - Given a chart, when AZ balancing is enabled, then replicas are distributed across availability zones.

- **Node selectors/tolerations/affinity**: Control pod scheduling (web-service, headless-service).
  - Feature BDD tests:
    - Given a chart, when a user sets a node selector, then the pod is scheduled on the correct node.
    - Given a chart, when a user sets tolerations, then the pod tolerates the specified taints.
    - Given a chart, when a user sets affinity rules, then the pod is scheduled according to the affinity rules.

- **Probes**: Liveness and readiness probes for health checks (web-service, headless-service).
  - Feature BDD tests:
    - Given a chart, when a user configures a liveness probe, then the pod includes the liveness probe.
    - Given a chart, when a user configures a readiness probe, then the pod includes the readiness probe.

- **Job history/limits**: Control how long jobs are retained after completion (cron-job, job, triggered-job).
  - Feature BDD tests:
    - Given a job chart, when a user sets a TTL for finished jobs, then jobs are deleted after the TTL expires.
    - Given a job chart, when a user sets a history limit, then only the specified number of job records are retained.

## Chart-Specific Features

### bandstand-web-service
- Ingress with custom domains, annotations, and visibility.
- Advanced scaling and AZ balancing.
- Kafka consumer group and topic configuration.

### bandstand-headless-service
- Headless service for direct pod-to-pod communication.
- Advanced scaling and AZ balancing.
- Kafka consumer group and topic configuration.

### bandstand-cron-job
- Cron scheduling for jobs.
- S3 volume mounting.
- Job history and concurrency policy.

### bandstand-job
- One-off job execution.
- Job history and backoff limit.

### bandstand-triggered-job
- Triggered by SQS queue events.
- Ignore in-flight message option.
- Job scaling based on queue depth.
- Job history and limits.

### bandstand-test-runner
- Define multiple test runs, each as a separate pod.
- Per-test environment and config support.

### bandstand-confluent-connect
- Deploy and manage Kafka Connect clusters and connectors.
- Connector configuration templating and overrides.
- Plugin management from Confluent Hub.

## Usage Notes
- Not all features are available in every chart. See the [Feature Matrix](./feature-matrix.md) for a quick comparison.
- For detailed configuration, refer to each chart's README and values.yaml.
- Some features (e.g., S3 volumes, advanced scaling) require additional setup or permissions in your cluster.

---

For more details, see the individual chart documentation in this directory.
