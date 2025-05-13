{{- define "bandstand-web-service.labels" -}}
system-code: {{ default .Release.Name .Values.systemCode }}
{{- if .Values.systemGroup }}
system-group: {{  .Values.systemGroup }}
{{- end }}
git-repo: {{ default .Release.Name .Values.gitRepo }}
provisioner: "Helm"
{{- if .Values.nameSuffix }}
application: {{ .Release.Name }}-{{ .Values.nameSuffix}}
tags.datadoghq.com/service: {{ .Release.Name }}-{{ .Values.nameSuffix}}
{{- else }}
application: {{ .Release.Name }}
tags.datadoghq.com/service: {{ .Release.Name }}
{{- end }}
version: {{ .Values.global.image.tag }}
tags.datadoghq.com/version: {{ .Values.global.image.tag }}
environment: {{ .Values.global.env }}
tags.datadoghq.com/env: {{ .Values.global.env }}
owner: {{ .Values.owner }}
{{- if (.Values.global.releaseTags).component }}
backstage/component: {{ .Values.global.releaseTags.component }}
{{- end }}
{{- if (.Values.global.releaseTags).system }}
backstage/system: {{ .Values.global.releaseTags.system }}
{{- end }}
{{- if (.Values.global.releaseTags).owner }}
backstage/owner: {{ .Values.global.releaseTags.owner }}
{{- end }}
bandstand/chart: '{{ .Chart.Name }}:{{ .Chart.Version }}'
{{- end }}

{{- define "bandstand-web-service.selectorLabels" -}}
{{- if .Values.nameSuffix }}
application: {{ .Release.Name }}-{{ .Values.nameSuffix}}
{{- else }}
application: {{ .Release.Name }}
{{- end }}
{{- end }}
