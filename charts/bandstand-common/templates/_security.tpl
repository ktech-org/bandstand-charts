{{/* Standard container security context */}}
{{- define "bandstand-common.security.container" -}}
runAsNonRoot: true
allowPrivilegeEscalation: false
readOnlyRootFilesystem: true
capabilities:
  drop:
    - ALL
seccompProfile:
  type: RuntimeDefault
{{- end -}}

{{/* Standard pod security context with configurable user and group */}}
{{- define "bandstand-common.security.pod" -}}
runAsUser: {{ .Values.runAsUser | default 1000 }}
fsGroup: {{ .Values.fsGroup | default 1000 }}
{{- end -}}
