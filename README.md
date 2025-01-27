# ashman-homelab-ops
Provides a method to deploy and maintain my homelab while trying to follow gitops practices. 
## Getting started
### Setup Requirements 
- Proxmox cluster

### Kubernetes
#### Sealed Secrets
For the initial bootstrap of the infrastructure cluster, deploy the sealed secrets secret. E.g:

`bw get notes kubeseal-secret | kubectl apply -f -`

#### Flux
To deploy the flux project, run this command:  

`flux bootstrap git --url='ssh://git@github.com/ashmantis1/kubernetes.git' --private-key-file=/home/asher/.ssh/id_ed25519 --path=kubernetes/clusters/infra`

