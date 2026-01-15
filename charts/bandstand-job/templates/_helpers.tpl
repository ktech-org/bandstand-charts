{{/*
Bandstand Job Chart Helpers
These helpers wrap the bandstand-common library chart for backwards compatibility.
*/}}

{{- define "bandstand-job.labels" -}}
{{- include "bandstand-common.labels.standard" (dict "serviceName" .Release.Name "context" .) }}
{{- end -}}

{{- define "bandstand-job.containerSecurityContext" -}}
{{- include "bandstand-common.security.container" . }}
{{- end -}}

{{- define "bandstand-job.podSecurityContext" -}}
{{- include "bandstand-common.security.pod" . }}
{{- end -}}

{{- define "bandstand-job.common-volumes" -}}
{{- include "bandstand-common.volumes.standard" (dict "releaseName" .Release.Name "context" .) }}
{{- end -}}

{{- define "bandstand-job.common-envvars" -}}
{{- include "bandstand-common.envvars.base" (dict "serviceName" .Release.Name "context" .) }}
{{- end -}}

{{- define "bandstand-job.workload.compute" -}}
{{- include "bandstand-common.workload.compute" . }}
{{- end -}}
