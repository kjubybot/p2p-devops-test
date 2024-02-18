package apps

appSpec: metricsServer: {
	name:          "metrics-server"
	repo:          "https://kubernetes-sigs.github.io/metrics-server"
	revision:      "3.12.0"
	chart:         "metrics-server"
	destNamespace: "default"
}
