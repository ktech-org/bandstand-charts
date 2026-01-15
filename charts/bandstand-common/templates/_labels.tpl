{{/* Standard labels for Bandstand workloads.
     Requires a dict with "serviceName" and "context" keys.

     Usage:
     {{- include "bandstand-common.labels.standard" (dict "serviceName" .Release.Name "context" .) }}
*/}}
{{- define "bandstand-common.labels.standard" -}}
{{- $serviceName := .serviceName -}}
{{- $ctx := .context -}}
application: {{ $serviceName }}
app.kubernetes.io/name: {{ $serviceName }}
app.kubernetes.io/version: {{ $ctx.Values.global.image.tag }}
helm.sh/chart: {{ printf "%s-%s" $ctx.Chart.Name $ctx.Chart.Version | replace "+" "_" }}
ktech.com/backstage-component: {{ $ctx.Values.global.releaseTags.backstageComponent }}
ktech.com/backstage-owner: {{ $ctx.Values.global.releaseTags.backstageOwner }}
{{- if $ctx.Values.global.releaseTags.backstageSystem }}
ktech.com/backstage-system: {{ $ctx.Values.global.releaseTags.backstageSystem }}
{{- end }}
tags.datadoghq.com/service: {{ $serviceName }}
tags.datadoghq.com/version: {{ $ctx.Values.global.image.tag }}
tags.datadoghq.com/env: {{ $ctx.Values.global.env }}
{{- end -}}

{{/* Selector labels for matching pods.
     Requires a dict with "serviceName" key.

     Usage:
     {{- include "bandstand-common.selectorLabels" (dict "serviceName" .Release.Name) }}
*/}}
{{- define "bandstand-common.selectorLabels" -}}
{{- $serviceName := .serviceName -}}
application: {{ $serviceName }}
{{- end -}}
