# Bandstand Charts

This is a public repo since it uses Github Pages to host a helm repository.

## Updating Library Charts

- Create branch for updates.
- Update `charts/{name}/templates` with changes.
- Bump `charts/{name}/Chart.yaml` version.
- Create PR from branch.
- Merge when approved, self-hosted helm repo will be updated.

Check the available versions [here](https://ktech-org.github.io/bandstand-charts/index.yaml).

## Using Library Charts

Add as a dependency in your `Chart.yaml`:
```
dependencies:
  - name: bandstand-web-service
    version: {version}
    repository: https://ktech-org.github.io/bandstand-charts/
```

And update dependencies:
```
helm dependency update .
```

This will add the dependency to the chart's `charts` subdirectory. 
