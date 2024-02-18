package apps

import argoapp "github.com/argoproj/argo-cd/v2/pkg/apis/application/v1alpha1"

_baseUrl: "k8s.orb.local"

appSpec: [Name=_]: {
	name:      *Name | string
	namespace: *"argocd" | string
	project:   *"default" | string
	repo:      string
	path?:     string
	revision:  string
	chart?:    string
	plugin?:       string
	destNamespace: *"argocd" | string
	values?: {}
}

apps: {
	for k, v in appSpec {
		"\(k)": argoapp.#Application & {
			apiVersion: "argoproj.io/v1alpha1"
			kind:       "Application"
			metadata: {
				name:      v.name
				namespace: v.namespace
			}
			spec: {
				project: v.project
				source: {
					repoURL:        v.repo
					targetRevision: v.revision
					if v.chart != null {
						chart: v.chart
					}
					if v.path != null {
						path: v.path
					}
					if v.plugin != null {
						plugin: name: v.plugin
					}
					if v.values != null {
						helm: valuesObject: v.values
					}
				}
				destination: {
					server:    "https://kubernetes.default.svc"
					namespace: v.destNamespace
				}
				syncPolicy: {
					automated: {}
					syncOptions: ["CreateNamespace=false"]
				}
			}
		}
	}
}
