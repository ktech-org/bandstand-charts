{{/* Standardizes compute strategy logic.
      Input: nodeStrategy { arch: string, capacityType: string }
*/}}
{{- define "bandstand-common.workload.compute" -}}
{{- $s := .Values.nodeStrategy | default dict -}}
{{- $arch := $s.arch | default "amd64" -}}
{{- $cap := $s.capacityType | default "on-demand" -}}

{{- /* 1. SELECTORS: We only hard-code the Architecture, capacity type is managed by tolerations and pool weights */}}
{{- if or (ne $arch "any") .Values.nodeSelector }}
nodeSelector:
  {{- if ne $arch "any" }}
  kubernetes.io/arch: {{ $arch | quote }}
  {{- end }}
  {{- with .Values.nodeSelector }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
{{- end }}

{{- /* 2. TOLERATIONS: These act as the 'Opt-in' mechanism */}}
tolerations:
  {{- if or (eq $arch "arm64") (eq $arch "any") }}
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
