# Bandstand Charts

This is a public repo since it uses Github Pages to host a helm repository.

## Chart References

[Cron Job](bandstand-cron-job.md)

[Triggered Job](bandstand-triggered-job.md)

[Test Runner](bandstand-test-runner.md)

[Web Service](bandstand-web-service.md)

[Headless Service](bandstand-headless-service.md)

[Job](bandstand-job.md)

[Confluent Connect Cluster](bandstand-confluent-connect.md)

## Values precedence

Values in `values-env.yaml` will override values in `values.yaml`.
The properties in the environment-specific file will be merged together,
and when the same value is specified in both places the env-specific values
will take precedence. The only exception is the environment variables values
because they are defined as a list and helm doesn't support merging lists,
that is why the charts provide two different values to for setting env vars
`additionalEnvVars` (for `values.yaml`) and `environmentEnvVars` (for `values-<env>.yaml`).

__NB__: The precedence is actually based on the ordering in the CircleCi config
(last file wins). The templates specify the env values file later, but if you
modify the ordering the behaviour will change.

## Updating Library Charts

- Create branch for updates.
- Update `charts/{name}/templates` with changes.
- Bump `charts/{name}/Chart.yaml` version.
- Create PR from branch.
- Merge when approved, self-hosted helm repo will be updated.

Check the available versions [here](https://ktech-org.github.io/bandstand-charts/index.yaml).

## Using Library Charts

Add as a dependency in your `Chart.yaml`:

```hcl
dependencies:
  - name: bandstand-web-service
    version: {version}
    repository: https://ktech-org.github.io/bandstand-charts/
```

And update dependencies:

```hcl
helm dependency update .
```

This will add the dependency to the chart's `charts` subdirectory.

## Migrating to Advanced Scaling

The `bandstand-web-service` and `bandstand-headless-service` charts both support advanced scaling options using
[KEDA](https://keda.sh/). This enables scaling to zero, scheduled scaling and scaling on external triggers such as kafka
messages. To see examples of scalers that can be used see the [test chart](https://github.com/ktech-org/bandstand-charts/blob/main/test-charts/web-service/advanced-scaling/values.yaml)

To migrate to advanced scaling you must first disable the HPA by setting `hpa.enabled`
to `false` in your `values.yaml` file. That change should be deployed to all clusters before proceeding. As a separate
deployment you can enable advanced scaling using KEDA by setting `advancedScaling.enabled` to `true` in your `values.yaml`
file and adding the required scalers.

If HPA is disabled and advanced scaling is enabled in the same deployment, the deployment will fail. If this is the case
contact the dev platform team for assistance as we will need to manually delete the old HPA resources from the clusters
to allow the deployment to proceed.

If you are interested in enabling other [KEDA scalers](https://keda.sh/docs/2.13/scalers/), please contact the dev
platform team or raise a PR.
