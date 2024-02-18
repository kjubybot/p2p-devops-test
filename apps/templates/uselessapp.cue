package apps

appSpec: uselessapp: {
	repo:     "https://github.com/kjubybot/p2p-devops-test.git"
	path: "webapp/chart"
	revision: "dev"
	values: {
		replicaCount: 3
		ingress: {
			enabled: true
			annotations: "traefik.ingress.kubernetes.io/router.tls": "true"
			hosts: [{
				host: "uselessapp.\(_baseUrl)"
				paths: [{
					path: "/"
					pathType: "Prefix"
				}]
			}]
		}
		resources: requests: cpu: "10m"
		autoscaling: {
			enabled: true
			minReplicas: 3
			maxReplicas: 5
			targetCPUUtilizationPercentage: 80
		}
	}
}
