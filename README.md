# bombardier-infra

1. Install terraform
2. Export aws iam_user profile to aws-cli, put this profile name into terraform.tfvars
3. ```terraform init```
4. put values in terraform.tfvars, tergets variable is array of strings in format "{IP}:{port}/{protocol[TCP,UDP]}" 
5. put ovpn files into ovpn folder
6. ```terraform apply``` to create infra 
7. ```terraform destroy``` to destroy infra
