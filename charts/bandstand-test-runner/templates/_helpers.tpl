{{- define "bandstand-test-runner.labels" -}}
application: {{ .Release.Name }}
version: {{ .Values.image.tag }}
environment: {{ .Values.env }}
owner: {{ .Values.owner }}
{{- end -}}
