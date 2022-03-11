# bombardier-infra

1. Install terraform
2. Export aws iam_user profile to aws-cli, put this profile name into terraform.tfvars
3. ```terraform init```
4. Put values in terraform.tfvars, targets variable is array of strings in format "{IP}:{port}/{protocol[TCP,UDP]}" 
5. Put ovpn files into ovpn folder
6. ```terraform apply``` to create infra 
7. ```terraform destroy``` to destroy infra
