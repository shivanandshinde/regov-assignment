# regov-assignment

## Desciption
- This will create the infrastructure as provided in question 2. 
- Amazon cognito and Appsync are left out due to time constraint. 
- CI/CD pipelines also left out due to time constraint.
- multi-account deployment is left out due to very less experience in that area.

## Setup
- Install terraform (version >= 0.12)
- Install awscli and create aws profile

`aws configure --profile test`

## How to run
- clone this repo 
- go to terraform directory - `cd terraform`
- Initialize terraform providers and modules - `terraform init`
- Validate configuration - `terraform validate`
- Plan the configuration - `terraform plan`
- Apply the configuration - `terraform apply`
- Destroy the configuration - `terraform destroy`