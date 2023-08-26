## Bootstrapping the cluster 

### Deploying argocd 
To deploy Argocd, run the command: `kubectl apply -k ./kubernetes/argocd` from the root of the repository. This will run deploy argocd with the required kustomization. 

### Deploying necessary SOPS secrets
There are currently only two secrets which are necessary for the cluster to function. The first of those is the argocd repository server, which allows argocd to access this repository. The second secret is the vault access token. This allows external-secrets to access vault, which is crucial for some services.
### Deploying the rest of the cluster
Now run: `kubectl apply -f ./bootstrap/application.yaml`. This will deploy the rest of the applications recursively using kustomize. It will also take control of the argocd application found in `./kubernetes/argocd`. This is done in the `./kubernetes/apps/argocd` which references the `./kubernetes/argocd`. 