{{- define "bandstand-confluent-connector.labels" -}}
system-code: {{ default .Release.Name .Values.systemCode }}
tags.datadoghq.com/service: {{ default .Release.Name .Values.systemCode }}
{{- if .Values.systemGroup }}
system-group: {{  .Values.systemGroup }}
{{- end }}
git-repo: {{ default .Release.Name .Values.gitRepo }}
provisioner: "Helm"
{{- if .Values.nameSuffix }}
application: {{ .Release.Name }}-{{ .Values.nameSuffix}}
{{- else }}
application: {{ .Release.Name }}
{{- end }}
version: {{ .Values.global.image.tag }}
tags.datadoghq.com/version: {{ .Values.global.image.tag }}
environment: {{ .Values.global.env }}
namespace: {{ .Values.global.namespace }}
tags.datadoghq.com/env: {{ .Values.global.env }}
owner: {{ .Values.owner }}
{{- end }}

{{- define "bandstand-confluent-connector.selectorLabels" -}}
{{- if .Values.nameSuffix }}
application: {{ .Release.Name }}-{{ .Values.nameSuffix}}
{{- else }}
application: {{ .Release.Name }}
{{- end }}
{{- end }}