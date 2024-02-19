### How to use that

This installation is intented to work with [OrbStack](https://orbstack.dev/),
so if you are using another k8s provider, you should change `_baseUrl` in `templates/apps.cue`
and `server.ingress.hostname` in `argocd/values.yaml`.

You also will need `helm` installed.

1. Add repo and install `argocd`
```shell
helm repo add argo https://argoproj.github.io/argo-helm
helm install -n argocd --create-namespace -f argocd/values.yaml argocd argo/argo-cd
```

2. Create apps
```shell
kubectl apply -f argocd/apps.yaml
```

3. Watch them creating
```shell
kubectl get applications -n argocd -w
```
Beautiful, innit?

4. Look at the namespaces created. One of them even has admin serviceaccount!
```shell
kubectl get namespaces
```

5. Try to open https://argocd.k8s.orb.local (or the url you put in `values.yaml`).
The password for `admin` user lays in `argocd-initial-admin-secret` secret in `argocd` namespace.

6. Try to open https://uselessapp.k8s.orb.local (or the `uselessapp.<_baseUrl>` if you changed it)

7. Try to put some load on the `uselessapp` endpoint. It should scale a wee horizontaly.

That's it. You're wonderful.
