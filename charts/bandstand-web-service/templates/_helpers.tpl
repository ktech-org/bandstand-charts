{{/*
Bandstand Web Service Chart Helpers
*/}}

{{- define "bandstand-web-service.fullname" -}}
{{- if .Values.nameSuffix -}}
{{ .Release.Name }}-{{ .Values.nameSuffix }}
{{- else -}}
{{ .Release.Name }}
{{- end -}}
{{- end }}

{{- define "bandstand-web-service.labels" -}}
{{- include "bandstand-common.labels.standard" (dict "serviceName" (include "bandstand-web-service.fullname" .) "context" .) }}
{{- end }}

{{- define "bandstand-web-service.selectorLabels" -}}
application: {{ include "bandstand-web-service.fullname" $ }}
{{- end }}

{{- define "bandstand-web-service.workload.compute" -}}
{{- include "bandstand-common.workload.compute" . }}
{{- end -}}
