{{/*
Bandstand Cron Job Chart Helpers
These helpers wrap the bandstand-common library chart for backwards compatibility.
*/}}

{{- define "bandstand-cron-job.labels" -}}
{{- include "bandstand-common.labels.standard" (dict "serviceName" .Release.Name "context" .) }}
{{- end -}}

{{- define "bandstand-cron-job.containerSecurityContext" -}}
{{- include "bandstand-common.security.container" . }}
{{- end -}}

{{- define "bandstand-cron-job.podSecurityContext" -}}
{{- include "bandstand-common.security.pod" . }}
{{- end -}}

{{- define "bandstand-cron-job.common-volumes" -}}
{{- include "bandstand-common.volumes.standard" (dict "releaseName" .Release.Name "context" .) }}
{{- end -}}

{{- define "bandstand-cron-job.common-envvars" -}}
{{- include "bandstand-common.envvars.base" (dict "serviceName" .Release.Name "context" .) }}
{{ include "bandstand-common.envvars.observability" (dict "serviceName" .Release.Name "context" .) }}
{{- end -}}

{{- define "bandstand-cron-job.workload.compute" -}}
{{- include "bandstand-common.workload.compute" . }}
{{- end -}}
