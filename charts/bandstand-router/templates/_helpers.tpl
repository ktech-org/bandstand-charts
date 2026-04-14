{{- define "bandstand-router.fullname" -}}
{{- if .Values.nameSuffix -}}
{{ .Release.Name }}-{{ .Values.nameSuffix }}
{{- else -}}
{{ .Release.Name }}
{{- end -}}
{{- end }}


{{- define "bandstand-router.labels" -}}
application: {{ include "bandstand-router.fullname" $ }}
app.kubernetes.io/name: {{ include "bandstand-router.fullname" $ }}
helm.sh/chart: bandstand-router-{{ .Chart.Version | replace "+" "_" }}
ktech.com/backstage-component: {{ .Values.global.releaseTags.backstageComponent }}
ktech.com/backstage-owner: {{ .Values.global.releaseTags.backstageOwner }}
{{- if .Values.global.releaseTags.backstageSystem }}
ktech.com/backstage-system: {{ .Values.global.releaseTags.backstageSystem }}
{{- end }}
{{- end }}
