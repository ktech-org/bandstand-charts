{{- define "bandstand-web-service.fullname" -}}
{{- if .Values.nameSuffix -}}
{{ .Release.Name }}-{{ .Values.nameSuffix }}
{{- else -}}
{{ .Release.Name }}
{{- end -}}
{{- end }}


{{- define "bandstand-web-service.labels" -}}
application: {{ include "bandstand-web-service.fullname" $ }}
app.kubernetes.io/name: {{ include "bandstand-web-service.fullname" $ }}
app.kubernetes.io/version: {{ .Values.global.image.tag }}
helm.sh/chart: {{ .Chart.Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
ktech.com/backstage-component: {{ .Values.global.releaseTags.backstageComponent }}
ktech.com/backstage-owner: {{ .Values.global.releaseTags.backstageOwner }}
{{- if .Values.global.releaseTags.backstageSystem }}
ktech.com/backstage-system: {{ .Values.global.releaseTags.backstageSystem }}
{{- end }}
tags.datadoghq.com/service: {{ include "bandstand-web-service.fullname" $ }}
tags.datadoghq.com/version: {{ .Values.global.image.tag }}
tags.datadoghq.com/env: {{ .Values.global.env }}
{{- end }}

{{- define "bandstand-web-service.selectorLabels" -}}
application: {{ include "bandstand-web-service.fullname" $ }}
{{- end }}
