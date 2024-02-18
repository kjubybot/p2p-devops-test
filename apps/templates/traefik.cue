package apps

appSpec: traefik: {
	repo:          "https://traefik.github.io/charts"
	revision:      "26.0.0"
	chart:         "traefik"
	destNamespace: "traefik"

	values:	{
		additionalArguments: ["--providers.kubernetesingress.ingressendpoint.publishedservice=NAMESPACE/TRAEFIK_SVC_NAME"]
		ports: web: redirectTo: port: "websecure"
	}
}
