{{- define "bandstand-triggered-job.labels" -}}
system-code: {{ default .Release.Name .Values.systemCode }}
tags.datadoghq.com/service: {{ default .Release.Name .Values.systemCode }}
{{- if .Values.systemGroup }}
system-group: {{  .Values.systemGroup }}
{{- end }}
git-repo: {{ default .Release.Name .Values.gitRepo }}
provisioner: "Helm"
application: {{ .Release.Name }}
version: {{ .Values.global.image.tag }}
tags.datadoghq.com/version: {{ .Values.global.image.tag }}
environment: {{ .Values.global.env }}
tags.datadoghq.com/env: {{ .Values.global.env }}
owner: {{ .Values.owner }}
{{- end -}}

{{- define "bandstand-triggered-job.containerSecurityContext" -}}
runAsNonRoot: true
allowPrivilegeEscalation: false
readOnlyRootFilesystem: true
capabilities:
  drop:
    - ALL
seccompProfile:
  type: RuntimeDefault
{{- end -}}

{{- define "bandstand-triggered-job.podSecurityContext" -}}
runAsUser: {{ .Values.runAsUser | default 1000  }}
fsGroup: {{ .Values.fsGroup | default 1000  }}
{{- end -}}

{{- define "bandstand-triggered-job.common-volumes" -}}
- name: tmp-dir
{{- if (.Values.volume).ephemeral }}
  ephemeral:
    volumeClaimTemplate:
      metadata:
        labels:
          type: temp-volume
      spec:
        accessModes: [ "ReadWriteOnce" ]
        storageClassName: {{ .Values.volume.storageClass | default "general-storage" }}
        resources:
          requests:
            storage: {{ .Values.volume.ephemeral }}
{{- else }}
  emptyDir: {}
{{- end }}
{{- if .Values.config }}
- name: config
  configMap:
    name: {{ .Release.Name }}
    items:
      {{- range .Values.config }}
      - key: {{ .filename }}
        path: {{ .filename }}
      {{- end }}
{{- end }}
{{- if .Values.envConfig }}
- name: env-config
  configMap:
    name: {{ .Release.Name }}-env
    items:
      {{- range .Values.envConfig }}
      - key: {{ .filename }}
        path: {{ .filename }}
      {{- end }}
{{- end }}
{{- if (.Values.volume).enabled }}
- name: {{ .Release.Name }}
  persistentVolumeClaim:
    claimName: {{ .Release.Name }}
{{- end }}
{{- end -}}

{{- define "bandstand-triggered-job.common-envvars" -}}
- name: ENV
  value: {{ .Values.global.env }}
- name: VERSION
  value: {{ .Values.global.image.tag }}
- name: BUSINESS
  value: {{ .Values.global.business | default "none"  }}
- name: DD_ENV
  value: {{ .Values.global.env }}
- name: DD_SERVICE
  value: {{ .Release.Name }}
- name: DD_VERSION
  value: {{ .Values.global.image.tag }}
- name: DD_AGENT_HOST
  valueFrom:
    fieldRef:
      fieldPath: status.hostIP
- name: OTEL_SERVICE_NAME
  value: {{ .Release.Name }}
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
- name: OTEL_RESOURCE_ATTRIBUTES
  value: host=$(DD_AGENT_HOST),service={{ .Release.Name }},env={{ .Values.global.env }}
- name: QUEUE_URL
  value: https://sqs.eu-west-1.amazonaws.com/{{ .Values.global.aws.account | toYaml }}/{{ .Values.queueName }}
- name: OTEL_INSTRUMENTATION_MICROMETER_ENABLED
  value: "true"
- name: OTEL_RESOURCE_PROVIDERS_AWS_ENABLED
  value: "true"
- name: OTEL_RESOURCE_ATTRIBUTES
  value: service={{ .Release.Name }},env={{ .Values.global.env }}
- name: AWS_ACCOUNT_ID
  value: {{ .Values.global.aws.account | squote }}
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
