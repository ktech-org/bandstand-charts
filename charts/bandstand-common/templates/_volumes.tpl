{{/* Standard volume definitions for Bandstand workloads.
     Includes tmp-dir, config, env-config, and persistent volumes.

     Requires a dict with "releaseName" and "context" keys.

     Usage:
     {{- include "bandstand-common.volumes.standard" (dict "releaseName" .Release.Name "context" .) }}
*/}}
{{- define "bandstand-common.volumes.standard" -}}
{{- $releaseName := .releaseName -}}
{{- $ctx := .context -}}
- name: tmp-dir
{{- if ($ctx.Values.volume).ephemeral }}
  ephemeral:
    volumeClaimTemplate:
      metadata:
        labels:
          type: temp-volume
      spec:
        accessModes: [ "ReadWriteOnce" ]
        storageClassName: {{ $ctx.Values.volume.storageClass | default "general-storage" }}
        resources:
          requests:
            storage: {{ $ctx.Values.volume.ephemeral }}
{{- else }}
  emptyDir: {}
{{- end }}
{{- if $ctx.Values.config }}
- name: config
  configMap:
    name: {{ $releaseName }}
    items:
      {{- range $ctx.Values.config }}
      - key: {{ .filename }}
        path: {{ .filename }}
      {{- end }}
{{- end }}
{{- if $ctx.Values.envConfig }}
- name: env-config
  configMap:
    name: {{ $releaseName }}-env
    items:
      {{- range $ctx.Values.envConfig }}
      - key: {{ .filename }}
        path: {{ .filename }}
      {{- end }}
{{- end }}
{{- if ($ctx.Values.volume).persistent }}
- name: {{ $releaseName }}
  persistentVolumeClaim:
    claimName: {{ $releaseName }}
{{- end }}
{{- end -}}
