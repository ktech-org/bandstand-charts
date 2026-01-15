# bandstand-common

Common Helm library chart for Bandstand workload charts.

## Overview

This library chart provides reusable template helpers to eliminate duplication across Bandstand charts. It includes:

- **Workload compute strategy** - Node selection and tolerations for architecture (amd64/arm64) and capacity type (on-demand/spot)
- **Security contexts** - Standard container and pod security contexts
- **Labels** - Backstage, Datadog, and Kubernetes labels
- **Environment variables** - Common DD, OTEL, AWS, and Kubernetes env vars
- **Volumes** - Standard volume definitions for config, env-config, tmp, and persistent volumes

## Usage

Add this library as a dependency in your Chart.yaml:

```yaml
dependencies:
  - name: bandstand-common
    version: "~0.1.0"
    repository: "https://ktech-org.github.io/bandstand-charts/"
```

For local development:

```yaml
dependencies:
  - name: bandstand-common
    version: "~0.1.0"
    repository: "file://../bandstand-common/"
```

Then include the helpers in your templates:

```yaml
{{- include "bandstand-common.workload.compute" . }}
```

## Available Helpers

### workload.compute
Standardizes node selection and tolerations based on `nodeStrategy.arch` and `nodeStrategy.capacityType`.

```yaml
{{- include "bandstand-common.workload.compute" . }}
```

### security.container
Standard container security context.

```yaml
{{- include "bandstand-common.security.container" . }}
```

### security.pod
Standard pod security context with configurable runAsUser and fsGroup.

```yaml
{{- include "bandstand-common.security.pod" . }}
```

### labels.standard
Generates standard Backstage, Datadog, and Kubernetes labels. Requires dict with `serviceName` and `context`:

```yaml
{{- include "bandstand-common.labels.standard" (dict "serviceName" .Release.Name "context" .) }}
```

### envvars.base
Core environment variables (ENV, VERSION, BUSINESS, DD_*, AWS_ACCOUNT_ID). Requires dict with `serviceName` and `context`:

```yaml
{{- include "bandstand-common.envvars.base" (dict "serviceName" .Release.Name "context" .) }}
```

### envvars.observability
Observability environment variables (OTEL_*, K8S_POD_*). Requires dict with `serviceName` and `context`:

```yaml
{{- include "bandstand-common.envvars.observability" (dict "serviceName" .Release.Name "context" .) }}
```

### volumes.standard
Standard volume definitions (tmp-dir, config, env-config, persistent). Requires dict with `releaseName` and `context`:

```yaml
{{- include "bandstand-common.volumes.standard" (dict "releaseName" .Release.Name "context" .) }}
```

## Maintainers

- ktech-developer-platform

## Version

Current version: 0.1.0 (beta)
