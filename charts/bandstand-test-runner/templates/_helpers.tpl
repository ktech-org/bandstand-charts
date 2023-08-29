{{- define "bandstand-test-runner.labels" -}}
system-code: {{ default .Release.Name .Values.systemCode }}
tags.datadoghq.com/service: {{ default .Release.Name .Values.systemCode }}
{{- if .Values.systemGroup }}
system-group: {{  .Values.systemGroup }}
{{- end }}
git-repo: {{ default .Release.Name .Values.gitRepo }}
provisioner: "Helm"
application: {{ .Release.Name }}-test-suite
version: {{ .Values.global.image.tag }}
tags.datadoghq.com/version: {{ .Values.global.image.tag }}
environment: {{ .Values.global.env }}
tags.datadoghq.com/env: {{ .Values.global.env }}
owner: {{ .Values.owner }}
{{- end -}}
