{{- define "bandstand.common.labels" -}}
system-code: {{ default .Release.Name .Values.systemCode }}
{{- if .Values.systemGroup }}
system-group: {{  .Values.systemGroup }}
{{- end }}
git-repo: {{ default .Release.Name .Values.gitRepo }}
provisioner: "Helm"
application: {{ .Release.Name }}
version: {{ .Values.image.tag }}
environment: {{ .Values.env }}
owner: {{ .Values.owner }}
{{- end -}}

{{- define "bandstand.common.containerSecurityContext" -}}
runAsNonRoot: true
allowPrivilegeEscalation: false
readOnlyRootFilesystem: true
capabilities:
  drop:
    - all
{{- end -}}

{{- define "bandstand.common.podSecurityContext" -}}
runAsUser: 1000
fsGroup: 1000
{{- end -}}

{{- define "bandstand.common.common-volumes" -}}
- name: tmp-dir
  emptyDir: {}
{{- if or .Values.properties .Values.envProperties }}
- name: config
  configMap:
    name: {{ .Release.Name }}
    items:
      - key: "app.properties"
        path: "app.properties"
{{- end }}
{{- if (.Values.volume).enabled }}
- name: {{ .Release.Name }}
  persistentVolumeClaim:
    claimName: {{ .Release.Name }}
{{- end }}
{{- end -}}

{{- define "bandstand.common.common-envvars" -}}
- name: ENV
  value: {{ .Values.env }}
- name: VERSION
  value: {{ .Values.image.tag }}
- name: DD_ENV
  value: {{ .Values.env }}
- name: DD_SERVICE
  value: {{ .Release.Name }}
- name: DD_VERSION
  value: {{ .Values.image.tag }}
- name: DD_AGENT_HOST
  valueFrom:
    fieldRef:
      fieldPath: status.hostIP
{{- end -}}
