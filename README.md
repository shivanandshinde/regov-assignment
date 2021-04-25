# regov-assignment

## Desciption
- This will create the infrastructure as provided in question 2. 
- Amazon cognito and Appsync are left out due to time constraint. 
- CI/CD pipelines also left out due to time constraint.
- multi-account deployment is left out due to very less experience in that area.

## Setup on linux os
- Install terraform (version >= 0.12) - https://learn.hashicorp.com/tutorials/terraform/install-cli
- Install awscli and create aws profile - https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html

`aws configure --profile test`

## How to run
- clone this repo 
- go to terraform directory - `cd terraform`
- Initialize terraform providers and modules - `terraform init`
- Validate configuration - `terraform validate`
- Plan the configuration - `terraform plan`
- Apply the configuration - `terraform apply`
- Destroy the configuration - `terraform destroy`