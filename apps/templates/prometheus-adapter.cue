package apps

appSpec: prometheusAdapter: {
	name:          "prometheus-adapter"
	repo:          "https://prometheus-community.github.io/helm-charts"
	revision:      "4.9.0"
	chart:         "prometheus-adapter"
	destNamespace: "prometheus"

	values: {
		prometheus: {
			url:  "http://prometheus-server.prometheus.svc"
			port: 80
		}
		rules: {
			default: false
			custom: [{
				seriesQuery: #"{__name__=~"^traefik_service_request_time"}"#
				resources: overrides: {
					namespace: resource: "namespace"
					service: resource:   "service"
				}
				metricsQuery: #"traefik_service_request_time{method="GET"}"#
			}]
		}
	}
}
