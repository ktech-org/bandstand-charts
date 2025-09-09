{{- define "bandstand-confluent-connect.labels" -}}
application: {{ .Release.Name }}
app.kubernetes.io/name: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.global.image.tag }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
ktech.com/backstage-component: {{ .Values.global.releaseTags.backstageComponent }}
ktech.com/backstage-owner: {{ .Values.global.releaseTags.backstageOwner }}
{{- if .Values.global.releaseTags.backstageSystem }}
ktech.com/backstage-system: {{ .Values.global.releaseTags.backstageSystem }}
{{- end }}
tags.datadoghq.com/service: {{ .Release.Name }}
tags.datadoghq.com/version: {{ .Values.global.image.tag }}
tags.datadoghq.com/env: {{ .Values.global.env }}
{{- end }}
