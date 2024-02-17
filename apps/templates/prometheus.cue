package apps

appSpec: prometheus: {
	repo:          "https://prometheus-community.github.io/helm-charts"
	revision:      "25.12.0"
	chart:         "prometheus"
	destNamespace: "prometheus"

	values: {
		server: persistentVolume: enabled: false
		serverFiles: {
			"recording_rules.yml": groups: [{
				name: "traefik"
				rules: [{
					record: "traefik_service_request_time"
					expr:   "sum(rate(traefik_service_request_duration_seconds_sum[1m])) by (service, method, namespace)"
				}]
			}]
			"prometheus.yml": {
				rule_files: ["/etc/config/recording_rules.yml"]
				scrape_configs: [{
					job_name:        "traefik"
					scrape_interval: "15s"
					honor_labels:    true
					kubernetes_sd_configs: [{role: "pod"}]
					relabel_configs: [{
						source_labels: ["__meta_kubernetes_pod_container_port_name"]
						regex:  "metrics"
						action: "keep"
					}, {
						source_labels: ["__meta_kubernetes_namespace"]
						action:       "replace"
						target_label: "namespace"
					}]
					metric_relabel_configs: [{
						regex:  "(job|protocol|instance)"
						action: "labeldrop"
					}, {
						source_labels: ["service"]
						regex:        #"^\w+-(.+)-\d+@.*$"#
						replacement:  "${1}"
						target_label: "service"
					}]
				}]
			}
		}
		alertmanager: enabled:               false
		"kube-state-metrics": enabled:       false
		"prometheus-node-exporter": enabled: false
		"prometheus-pushgateway": enabled:   false
	}
}
