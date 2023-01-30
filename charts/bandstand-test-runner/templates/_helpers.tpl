{{- define "bandstand-test-runner.labels" -}}
system-code: {{ default .Release.Name .Values.systemCode }}
{{- if .Values.systemGroup }}
system-group: {{  .Values.systemGroup }}
{{- end }}
git-repo: {{ default .Release.Name .Values.gitRepo }}
provisioner: "Helm"
application: {{ .Release.Name }}
version: {{ .Values.global.image.tag }}
environment: {{ .Values.global.env }}
owner: {{ .Values.owner }}
{{- end -}}
