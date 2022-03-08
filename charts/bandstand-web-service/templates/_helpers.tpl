{{- define "bandstand-web-service.labels" -}}
system-code: {{ default .Release.Name .Values.systemCode }}
{{ if .Values.systemGroup }} system-group: {{  .Values.systemGroup }} {{ end }}
git-repo: {{ .Values.gitRepo }}
provisioner: "kubernetes"
application: {{ .Release.Name }}
version: {{ .Values.image.tag }}
environment: {{ .Values.env }}
owner: {{ .Values.owner }}
{{- end }}

{{- define "bandstand-web-service.selectorLabels" -}}
application: {{ .Release.Name }}
{{- end }}
