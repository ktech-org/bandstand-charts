{{- define "bandstand-router.labels" -}}
application: {{ .Release.Name }}
app.kubernetes.io/name: {{ .Release.Name }}
helm.sh/chart: bandstand-router-{{ .Chart.Version | replace "+" "_" }}
ktech.com/backstage-component: {{ .Values.global.releaseTags.backstageComponent }}
ktech.com/backstage-owner: {{ .Values.global.releaseTags.backstageOwner }}
{{- if .Values.global.releaseTags.backstageSystem }}
ktech.com/backstage-system: {{ .Values.global.releaseTags.backstageSystem }}
{{- end }}
{{- end }}
