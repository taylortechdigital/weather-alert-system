{{/*
Return the chart name.
*/}}
{{- define "weather-alerts.name" -}}
weather-alerts
{{- end -}}

{{/*
Return the fully qualified name.
*/}}
{{- define "weather-alerts.fullname" -}}
{{ include "weather-alerts.name" . }}
{{- end -}}
