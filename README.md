# ashman-homelab-ops
Provides a method to deploy and maintain my homelab while trying to follow gitops practices. 

## DNS Records
DNS records are managed using RFC 2186, to automatically update and add records. This is done primarly through the Terraform DNS provider. Currently general records are found in `./infrastructure/general/dns` and other records can be found in their respective projects, such as k8s records. 