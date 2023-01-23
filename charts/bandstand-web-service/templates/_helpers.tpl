{{- define "bandstand-web-service.labels" -}}
system-code: {{ default .Release.Name .Values.systemCode }}
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
environment: {{ .Values.env }}
owner: {{ .Values.owner }}
{{- end }}

{{- define "bandstand-web-service.selectorLabels" -}}
{{- if .Values.nameSuffix }}
application: {{ .Release.Name }}-{{ .Values.nameSuffix}}
{{- else }}
application: {{ .Release.Name }}
{{- end }}
{{- end }}
