{{- define "bandstand-cron-job.labels" -}}
system-code: {{ default .Release.Name .Values.systemCode }}
{{- if .Values.systemGroup -}}
system-group: {{  .Values.systemGroup }}
{{- end -}}
git-repo: {{ default .Release.Name .Values.gitRepo }}
provisioner: "Helm"
application: {{ .Release.Name }}
version: {{ .Values.image.tag }}
environment: {{ .Values.env }}
owner: {{ .Values.owner }}
{{- end -}}

{{- define "bandstand-cron-job.containerSecurityContext" -}}
runAsNonRoot: true
allowPrivilegeEscalation: false
readOnlyRootFilesystem: true
capabilities:
  drop:
    - all
{{- end -}}

{{- define "bandstand-cron-job.podSecurityContext" -}}
runAsUser: 1000
fsGroup: 1000
{{- end -}}

{{- define "bandstand-cron-job.common-volumes" -}}
- name: tmp-dir
  emptyDir: {}
{{- if .Values.properties }}
- name: config
  configMap:
    name: {{ .Release.Name }}
    items:
      - key: "app.properties"
        path: "app.properties"
{{- end -}}
{{- end -}}

{{- define "bandstand-cron-job.common-envvars" -}}
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
