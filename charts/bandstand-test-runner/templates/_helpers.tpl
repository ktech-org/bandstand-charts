{{- define "bandstand-test-runner.labels" -}}
application: {{ .Release.Name }}
app.kubernetes.io/name: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.global.image.tag }}
helm.sh/chart: bandstand-test-runner-{{ .Chart.Version | replace "+" "_" }}
ktech.com/backstage-component: {{ .Values.global.releaseTags.backstageComponent }}
ktech.com/backstage-owner: {{ .Values.global.releaseTags.backstageOwner }}
{{- if .Values.global.releaseTags.backstageSystem }}
ktech.com/backstage-system: {{ .Values.global.releaseTags.backstageSystem }}
{{- end }}
tags.datadoghq.com/service: {{ .Release.Name }}
tags.datadoghq.com/version: {{ .Values.global.image.tag }}
tags.datadoghq.com/env: {{ .Values.global.env }}
{{- end -}}

{{/* Standardizes compute strategy logic.
      Input: nodeStrategy { pool: string, arch: string }
*/}}
{{- define "bandstand-test-runner.workload.compute" -}}
{{- $s := .Values.nodeStrategy | default dict -}}
{{- $arch := $s.arch | default "amd64" -}}
{{- $cap := $s.capacityType | default "on-demand" -}}

{{- /* 1. SELECTORS: We only hard-code the Architecture, capacity type is managed by tolerations and pool weights */}}
nodeSelector:
  kubernetes.io/arch: {{ $arch | quote }}
  {{- with .Values.nodeSelector }}
  {{- toYaml . | nindent 2 }}
  {{- end }}

{{- /* 2. TOLERATIONS: These act as the 'Opt-in' mechanism */}}
tolerations:
  {{- if eq $arch "arm64" }}
  - key: "ktech.com/arch"
    operator: "Equal"
    value: "arm64"
    effect: "NoSchedule"
  {{- end }}

  {{- /* Only relevant in prod. For non-prod envs spot automatically takes precedence */}}
  {{- if eq $cap "spot" }}
  - key: "ktech.com/capacity-type"
    operator: "Equal"
    value: "spot"
    effect: "NoSchedule"
  {{- end }}
{{- end -}}
