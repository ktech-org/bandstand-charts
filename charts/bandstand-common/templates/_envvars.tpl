{{/* Base environment variables common to all Bandstand workloads.
     Includes ENV, VERSION, BUSINESS, DD_*, and AWS_ACCOUNT_ID.

     Requires a dict with "serviceName" and "context" keys.

     Usage:
     {{- include "bandstand-common.envvars.base" (dict "serviceName" .Release.Name "context" .) }}
*/}}
{{- define "bandstand-common.envvars.base" -}}
{{- $serviceName := .serviceName -}}
{{- $ctx := .context -}}
- name: ENV
  value: {{ $ctx.Values.global.env }}
- name: VERSION
  value: {{ $ctx.Values.global.image.tag }}
- name: BUSINESS
  value: {{ $ctx.Values.global.business | default "none" }}
- name: DD_ENV
  value: {{ $ctx.Values.global.env }}
- name: DD_SERVICE
  value: {{ $serviceName }}
- name: DD_VERSION
  value: {{ $ctx.Values.global.image.tag }}
- name: DD_AGENT_HOST
  valueFrom:
    fieldRef:
      fieldPath: status.hostIP
- name: AWS_ACCOUNT_ID
  value: {{ $ctx.Values.global.aws.account | squote }}
{{- end -}}

{{/* Observability environment variables (OTEL and Kubernetes pod info).
     Includes OTEL_* and K8S_POD_* variables.

     Requires a dict with "serviceName" and "context" keys.

     Usage:
     {{- include "bandstand-common.envvars.observability" (dict "serviceName" .Release.Name "context" .) }}
*/}}
{{- define "bandstand-common.envvars.observability" -}}
{{- $serviceName := .serviceName -}}
{{- $ctx := .context -}}
- name: OTEL_SERVICE_NAME
  value: {{ $serviceName }}
- name: OTEL_EXPORTER_OTLP_ENDPOINT
  value: http://collector.linkerd-jaeger:4317
- name: OTEL_PROPAGATORS
  value: b3multi
- name: OTEL_EXPORTER_OTLP_METRICS_ENDPOINT
  value: http://$(DD_AGENT_HOST):4317
- name: OTEL_EXPORTER_OTLP_METRICS_PROTOCOL
  value: grpc
- name: OTEL_METRICS_EXPORTER
  value: otlp
- name: OTEL_EXPORTER_OTLP_PROTOCOL
  value: grpc
- name: OTEL_LOGS_EXPORTER
  value: none
- name: OTEL_JAVA_DISABLED_RESOURCE_PROVIDERS
  value: io.opentelemetry.sdk.extension.resources.HostResourceProvider,io.opentelemetry.sdk.extension.resources.ContainerResourceProvider
- name: OTEL_INSTRUMENTATION_MICROMETER_ENABLED
  value: "true"
- name: OTEL_RESOURCE_PROVIDERS_AWS_ENABLED
  value: "true"
- name: OTEL_RESOURCE_ATTRIBUTES
{{- if $ctx.Values.global.releaseTags.backstageSystem }}
  value: service={{ $serviceName }},env={{ $ctx.Values.global.env }},system={{ $ctx.Values.global.releaseTags.backstageSystem }},team={{ $ctx.Values.global.releaseTags.backstageOwner }}
{{- else }}
  value: service={{ $serviceName }},env={{ $ctx.Values.global.env }},team={{ $ctx.Values.global.releaseTags.backstageOwner }}
{{- end }}
- name: K8S_POD_UID
  valueFrom:
    fieldRef:
      apiVersion: v1
      fieldPath: metadata.uid
- name: K8S_POD_NAME
  valueFrom:
    fieldRef:
      apiVersion: v1
      fieldPath: metadata.name
{{- end -}}
