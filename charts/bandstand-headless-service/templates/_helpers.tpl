{{/*
Bandstand Headless Service Chart Helpers
*/}}

{{- define "bandstand-headless-service.fullname" -}}
{{- if .Values.nameSuffix -}}
{{ .Release.Name }}-{{ .Values.nameSuffix }}
{{- else -}}
{{ .Release.Name }}
{{- end -}}
{{- end }}

{{- define "bandstand-headless-service.labels" -}}
{{- include "bandstand-common.labels.standard" (dict "serviceName" (include "bandstand-headless-service.fullname" .) "context" .) }}
{{- end }}

{{- define "bandstand-headless-service.selectorLabels" -}}
application: {{ include "bandstand-headless-service.fullname" $ }}
{{- end }}

{{- define "bandstand-headless-service.workload.compute" -}}
{{- include "bandstand-common.workload.compute" . }}
{{- end -}}
