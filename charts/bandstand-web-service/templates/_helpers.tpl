{{- define "bandstand-web-service.labels" -}}
application: {{ .Release.Name }}
version: {{ .Values.image.tag }}
environment: {{ .Values.env }}
owner: {{ .Values.owner }}
{{- end }}

{{- define "bandstand-web-service.selectorLabels" -}}
application: {{ .Release.Name }}
{{- end }}
