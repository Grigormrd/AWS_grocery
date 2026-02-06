# GroceryMate – AWS MVP (Terraform)

A small but complete **AWS MVP** showing cloud engineering skills: Infrastructure as Code, secure-by-default configuration, and a deployable application runtime on EC2.

## What this repo demonstrates (for recruiters)
- **Terraform IaC** with a tidy structure (`main.tf`, `variables.tf`, `outputs.tf`, `provider.tf` + split resource files)
- **S3** avatar bucket (private, versioning enabled)
- **IAM** instance role with least‑privilege S3 access
- **EC2** instance + Security Group (SSH + App port)
- **CloudWatch as Code**: dashboard + CPU alarm (+ optional email notifications via SNS)
- Clear **deployment steps** and reproducibility

## Architecture (high level)

User → `EC2 (Dockerized app on :5000)`  
             ↘ uploads → `S3 (avatars bucket)`  
             ↘ metrics → `CloudWatch (dashboard + alarms)`

> Database (RDS/Postgres) can be kept manual for the MVP or added later as Terraform.

---

## Repo structure (curriculum-ready)

- `infrastructure/` (**Week 6**) – all IaC lives here  
- `infrastructure/terraform/` (**Week 8**) – organized Terraform root module  
- `infrastructure/terraform/cloudwatch.tf` (**Week 9**) – CloudWatch as code

---

## Deploy (Terraform)

### 1) Prerequisites
- Terraform ≥ 1.5
- AWS credentials configured **or** run Terraform on an EC2 instance with a provisioning IAM role

### 2) Configure variables
```bash
cd infrastructure/terraform
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` (bucket name must be globally unique; set your key pair name and your IP).

### 3) Apply
```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

### 4) Verify
Terraform outputs:
- `ec2_public_ip`
- `avatars_bucket_name`
- `cloudwatch_dashboard_name`
- `cpu_alarm_name`

Open the app:
`http://<ec2_public_ip>:5000`

---

## Clean-up
```bash
cd infrastructure/terraform
terraform destroy
```