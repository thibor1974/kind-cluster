{{/*
Expand the name of the chart.
*/}}
{{- define "simple-web-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "simple-web-server.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "simple-web-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Get deployment-specific configuration from values
*/}}
{{- define "simple-web-server.deploymentConfig" -}}
{{- index .Values.deployments .Chart.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "simple-web-server.labels" -}}
helm.sh/chart: {{ include "simple-web-server.chart" . }}
{{ include "simple-web-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "simple-web-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "simple-web-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
