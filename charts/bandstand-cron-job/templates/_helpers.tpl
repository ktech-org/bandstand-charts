{{- define "bandstand-cron-job.labels" -}}
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

{{- define "bandstand-cron-job.containerSecurityContext" -}}
runAsNonRoot: true
allowPrivilegeEscalation: false
readOnlyRootFilesystem: true
capabilities:
  drop:
    - ALL
seccompProfile:
  type: RuntimeDefault
{{- end -}}

{{- define "bandstand-cron-job.podSecurityContext" -}}
runAsUser: {{ .Values.runAsUser | default 1000  }}
fsGroup: {{ .Values.fsGroup | default 1000  }}
{{- end -}}

{{- define "bandstand-cron-job.common-volumes" -}}
- name: tmp-dir
{{- if (.Values.volume).ephemeral }}
  ephemeral:
    volumeClaimTemplate:
      metadata:
        labels:
          type: temp-volume
      spec:
        accessModes: [ "ReadWriteOnce" ]
        storageClassName: "gp2"
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
{{- if (.Values.volume).persistent }}
- name: {{ .Release.Name }}
  persistentVolumeClaim:
    claimName: {{ .Release.Name }}
{{- end }}
{{- end -}}

{{- define "bandstand-cron-job.common-envvars" -}}
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
  value: "grpc"
- name: OTEL_LOGS_EXPORTER
  value: "none"
- name: OTEL_JAVA_DISABLED_RESOURCE_PROVIDERS
  value: io.opentelemetry.sdk.extension.resources.HostResourceProvider,io.opentelemetry.sdk.extension.resources.ContainerResourceProvider
- name: OTEL_RESOURCE_ATTRIBUTES
  value: host=$(DD_AGENT_HOST),service={{ .Release.Name }},env={{ .Values.global.env }}
- name: AWS_ACCOUNT_ID
  value: {{ .Values.global.aws.account | squote }}
{{- end -}}
