{{/*
Bandstand Test Runner Chart Helpers
These helpers wrap the bandstand-common library chart for backwards compatibility.
*/}}

{{- define "bandstand-test-runner.labels" -}}
{{- include "bandstand-common.labels.standard" (dict "serviceName" .Release.Name "context" .) }}
{{- end -}}

{{- define "bandstand-test-runner.workload.compute" -}}
{{- include "bandstand-common.workload.compute" . }}
{{- end -}}
