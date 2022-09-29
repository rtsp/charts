{{/*
Expand the name of the chart.
*/}}
{{- define "argocd-manager.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "argocd-manager.fullname" -}}
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
{{- define "argocd-manager.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "argocd-manager.labels" -}}
helm.sh/chart: {{ include "argocd-manager.chart" . }}
{{ include "argocd-manager.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "argocd-manager.selectorLabels" -}}
app.kubernetes.io/name: {{ include "argocd-manager.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "argocd-manager.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "argocd-manager.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account token secret to use
*/}}
{{- define "argocd-manager.serviceAccountTokenSecretName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (printf "%s-token" (include "argocd-manager.serviceAccountName" .)) .Values.serviceAccount.tokenSecret.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the cluster role to use
*/}}
{{- define "argocd-manager.clusterRoleName" -}}
{{- if .Values.clusterRole.create }}
{{- default (printf "%s-role" (include "argocd-manager.fullname" .)) .Values.clusterRole.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the cluster role binding to use
*/}}
{{- define "argocd-manager.clusterRoleBindingName" -}}
{{- if .Values.clusterRoleBinding.create }}
{{- default (printf "%s-role-binding" (include "argocd-manager.fullname" .)) .Values.clusterRoleBinding.name }}
{{- end }}
{{- end }}
