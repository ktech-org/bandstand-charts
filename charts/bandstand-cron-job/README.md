# Bandstand cron job

## Values

| Key                       | Type   | Default        | Description                                                                                                                                                                                                                                                                                    |
|---------------------------|--------|----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| additionalEnvVars         | object | `{}`           | An object containing additional environment variables                                                                                                                                                                                                                                          |
| aws.account               | string |                | The account number of the deployment either the test, preprod or prod account                                                                                                                                                                                                                  |
| env                       | string |                | The environment, either test, preprod or prod                                                                                                                                                                                                                                                  |
| gitRepo                   | string | `.Release.Name`| The name of the repository for the service                                                                                                                                                                                                                                                     |
| image.tag                 | string |                | The tag for container image to be used in the serivce                                                                                                                                                                                                                                          |
| jobContainer.arguments    | list   |                | Override the default container arguments for the job Pod                                                                                                                                                                                                                                       |
| jobContainer.command      | string |                | Override the default container command for the job Pod                                                                                                                                                                                                                                         |
| owner                     | string |                | The GitHub team that owns the service                                                                                                                                                                                                                                                          |
| properties                | object | `{}`           | An object containing properties for the job - use this for base properties in values.yaml. The final properties object is a concatination of properties and envProperties.                                                                                                                     |
| envProperties             | object | `{}`           | An object containing properties for the job - use this for environment specific values in the <env>-values.yaml files. The final properties object is a concatination of properties and envProperties.                                                                                         |
| resources.limits.memory   | string | `512Mi`        | Container memory [limit](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits), see [here](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-memory)                                                     |
| resources.requests.cpu    | string |  `250m`        | [Requests](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits) for container CPU resources measured in cpu units, one core is 1000m, see [here](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-cpu) |
| resources.requests.memory | string | `256Mi`        | Container memory [Requests](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits)see [here](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-memory)                                                    |
| systemCode                | string | `.Release.Name`| The systemCode for the service                                                                                                                                                                                                                                                                 |
| systemGroup               | string |                | The systemGroup for the service                                                                                                                                                                                                                                                                |
| backoffLimit              | number | `6`            | [Back off limit](https://kubernetes.io/docs/concepts/workloads/controllers/job/#pod-backoff-failure-policy) To prevent restart on failure set to 0                                                                                                                                             |
| concurrencyPolicy         | string | `Allow`        | [Concurrency Policy](https://kubernetes.io/docs/tasks/job/automated-tasks-with-cron-jobs/#concurrency-policy) To prevent restart on failure set to `Forbid`                                                                                                                                    |