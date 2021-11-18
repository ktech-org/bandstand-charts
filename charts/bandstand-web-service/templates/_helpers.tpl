{{- define "service-library.labels" -}}
application: {{ .Release.Name }}
version: {{ .Values.image.tag }}
environment: {{ .Values.env }}
owner: {{ .Values.owner }}
{{- end }}

{{- define "service-library.selectorLabels" -}}
application: {{ .Release.Name }}
{{- end }}