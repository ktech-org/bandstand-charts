# Usage

## Library Charts

Add as a dependency in `Chart.yaml`:
```
dependencies:
  - name: service-library
    version: 0.1.0
    repository: https://ktech-org.github.io/bandstand-charts/
```

And update dependencies:
```
helm dependency update .
```

This will add the dependency to the chart's `charts` subdirectory. 