# Bandstand Charts

This is a public repo since it uses Github Pages to host a helm repository.

## Chart References

[Cron Job](bandstand-cron-job.md)

[Triggered Job](bandstand-triggered-job.md)

[Test Runner](bandstand-test-runner.md)

[Web Service](bandstand-web-service.md)

[Headless Service](bandstand-headless-service.md)

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
