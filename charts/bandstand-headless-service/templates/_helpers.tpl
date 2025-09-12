{{- define "bandstand-headless-service.fullname" -}}
{{- if .Values.nameSuffix -}}
{{ .Release.Name }}-{{ .Values.nameSuffix }}
{{- else -}}
{{ .Release.Name }}
{{- end -}}
{{- end }}

{{- define "bandstand-headless-service.labels" -}}
application: {{ include "bandstand-headless-service.fullname" $ }}
app.kubernetes.io/name: {{ include "bandstand-headless-service.fullname" $ }}
app.kubernetes.io/version: {{ .Values.global.image.tag }}
helm.sh/chart: bandstand-headless-service-{{ .Chart.Version | replace "+" "_" }}
ktech.com/backstage-component: {{ .Values.global.releaseTags.backstageComponent }}
ktech.com/backstage-owner: {{ .Values.global.releaseTags.backstageOwner }}
{{- if .Values.global.releaseTags.backstageSystem }}
ktech.com/backstage-system: {{ .Values.global.releaseTags.backstageSystem }}
{{- end }}
tags.datadoghq.com/service: {{ include "bandstand-headless-service.fullname" $ }}
tags.datadoghq.com/version: {{ .Values.global.image.tag }}
tags.datadoghq.com/env: {{ .Values.global.env }}
{{- end }}

{{- define "bandstand-headless-service.selectorLabels" -}}
application: {{ include "bandstand-headless-service.fullname" $ }}
{{- end }}
