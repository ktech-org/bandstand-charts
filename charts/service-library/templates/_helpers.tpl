{{- define "service-library.labels" -}}
application: {{ .Release.Name }}
version: {{ .Values.image.tag }}
environment: {{ .Values.env }}
managed-by: {{ .Release.Service }}
owner: {{ .Values.team }}
{{- end }}

{{- define "service-library.selectorLabels" -}}
application: {{ .Release.Name }}
{{- end }}