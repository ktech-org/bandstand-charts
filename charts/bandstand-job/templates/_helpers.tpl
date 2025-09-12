{{- define "bandstand-job.labels" -}}
application: {{ .Release.Name }}
app.kubernetes.io/name: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.global.image.tag }}
helm.sh/chart: bandstand-job-{{ .Chart.Version | replace "+" "_" }}
ktech.com/backstage-component: {{ .Values.global.releaseTags.backstageComponent }}
ktech.com/backstage-owner: {{ .Values.global.releaseTags.backstageOwner }}
{{- if .Values.global.releaseTags.backstageSystem }}
ktech.com/backstage-system: {{ .Values.global.releaseTags.backstageSystem }}
{{- end }}
tags.datadoghq.com/service: {{ .Release.Name }}
tags.datadoghq.com/version: {{ .Values.global.image.tag }}
tags.datadoghq.com/env: {{ .Values.global.env }}
{{- end -}}

{{- define "bandstand-job.containerSecurityContext" -}}
runAsNonRoot: true
allowPrivilegeEscalation: false
readOnlyRootFilesystem: true
capabilities:
  drop:
    - ALL
seccompProfile:
  type: RuntimeDefault
{{- end -}}

{{- define "bandstand-job.podSecurityContext" -}}
runAsUser: {{ .Values.runAsUser | default 1000  }}
fsGroup: {{ .Values.fsGroup | default 1000  }}
{{- end -}}

{{- define "bandstand-job.common-volumes" -}}
- name: tmp-dir
{{- if (.Values.volume).ephemeral }}
  ephemeral:
    volumeClaimTemplate:
      metadata:
        labels:
          type: temp-volume
      spec:
        accessModes: [ "ReadWriteOnce" ]
        storageClassName: {{ .Values.volume.storageClass | default "general-storage" }}
        resources:
          requests:
            storage: {{ .Values.volume.ephemeral }}
{{- else }}
  emptyDir: {}
{{- end }}
{{- if .Values.config }}
- name: config
  configMap:
    name: {{ .Release.Name }}
    items:
      {{- range .Values.config }}
      - key: {{ .filename }}
        path: {{ .filename }}
      {{- end }}
{{- end }}
{{- if .Values.envConfig }}
- name: env-config
  configMap:
    name: {{ .Release.Name }}-env
    items:
      {{- range .Values.envConfig }}
      - key: {{ .filename }}
        path: {{ .filename }}
      {{- end }}
{{- end }}
{{- if (.Values.volume).persistent }}
- name: {{ .Release.Name }}
  persistentVolumeClaim:
    claimName: {{ .Release.Name }}
{{- end }}
{{- end -}}

{{- define "bandstand-job.common-envvars" -}}
- name: ENV
  value: {{ .Values.global.env }}
- name: VERSION
  value: {{ .Values.global.image.tag }}
- name: BUSINESS
  value: {{ .Values.global.business | default "none"  }}
- name: DD_ENV
  value: {{ .Values.global.env }}
- name: DD_SERVICE
  value: {{ .Release.Name }}
- name: DD_VERSION
  value: {{ .Values.global.image.tag }}
- name: DD_AGENT_HOST
  valueFrom:
    fieldRef:
      fieldPath: status.hostIP
- name: AWS_ACCOUNT_ID
  value: {{ .Values.global.aws.account | squote }}
{{- end -}}
