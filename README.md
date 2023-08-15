# ashman-homelab-ops
Provides a method to deploy and maintain my homelab while trying to follow gitops practices. 
## Getting started
### Setup Requirements 
- Proxmox cluster
- 
### 
Deploying this project
First navigate to `./infrastructure/kubernetes/ansible/inventory/group_vars/vars.yaml` and set all the necessary variables. This is important as these variables are used for both the ansible and the terraform that is being run. 
To deploy the kubernetes cluster, navigate to the root directory and run `ansible-playbook -i ansible/inventory/inventory.ini deploy.yaml`. This will deploy all nodes specified on your Proxmox cluster. 
To deploy the argocd application, navigate to `./kubernetes/argocd` and run `kubectl apply -k .` to run the kustomizations, then just apply the application with `kubectl apply -f application.yaml`. 



## DNS Records
DNS records are managed using RFC 2186, to automatically update and add records. This is done primarly through the Terraform DNS provider. Currently general records are found in `./infrastructure/general/dns` and other records can be found in their respective projects, such as k8s records. 