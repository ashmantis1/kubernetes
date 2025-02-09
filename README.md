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


#### Restoring from Backups
##### Gitlab
To restore gitlab, first create the gitlab rails secret (delete pre-existing secret):
`bw get notes gitlab-rails-secret | kubectl apply -f -`

Then run the backup restore command:
`kubectl exec -it deploy/gitlab-toolbox -- backup-utility --restore -t 1739087156_2025_02_09_17.8.1-ee --s3tool awscli --aws-s3-endpoint-url https://minio01.infra.ashman.world`
