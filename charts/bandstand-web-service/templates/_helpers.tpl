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
helm.sh/chart: bandstand-web-service-{{ .Chart.Version | replace "+" "_" }}
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

{{/* Standardizes compute strategy logic.
      Input: nodeStrategy { pool: string, arch: string }
*/}}
{{- define "bandstand-web-service.workload.compute" -}}
{{- $s := .Values.nodeStrategy | default dict -}}
{{- $pool := $s.pool | default "default" -}}
{{- $arch := $s.arch | default "amd64" -}}

{{/* SAFETY CHECK: Hard-stop if someone tries Graviton on AMD binaries */}}
{{- if and (eq $pool "graviton") (ne $arch "arm64") -}}
  {{- fail "\n[FATAL] The 'graviton' pool requires architecture to be set to 'arm64'." -}}
{{- end -}}

{{/* 1. SELECTORS: High-level intent + custom overrides */}}
nodeSelector:
  ktech.com/nodepool: {{ $pool | quote }}
  kubernetes.io/arch: {{ $arch | quote }}
{{- with .Values.nodeSelector }}
{{- toYaml . | nindent 2 }}
{{- end }}

{{/* 2. TOLERATIONS: Generic lock/key logic */}}
{{- if ne $pool "default" }}
tolerations:
  - key: "ktech.com/nodepool"
    operator: "Equal"
    value: {{ $pool | quote }}
    effect: "NoSchedule"
{{- end }}
{{- end -}}
