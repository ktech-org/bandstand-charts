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
  emptyDir: {}
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
- name: QUEUE_URL
  value: https://sqs.eu-west-1.amazonaws.com/{{ .Values.global.aws.account | toYaml }}/{{ .Values.queueName }}
- name: AWS_ACCOUNT_ID
  value: {{ .Values.global.aws.account | squote }}
{{- end -}}
