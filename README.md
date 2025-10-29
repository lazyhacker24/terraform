# AWS + Terraform Deployment (Flask + Express)

## Part 1
- Deploy both apps on one EC2
- Flask → port 5000  
- Express → port 3000  
- Run:
  ```bash
  terraform init
  terraform plan
  terraform apply
Then visit:
http://<EC2-IP>:3000 → Express
http://<EC2-IP>:5000 → Flask

Part 2
Two EC2 instances (one Flask, one Express)

Add communication security groups in Terraform

Part 3
Dockerize both apps

Push to AWS ECR

Use ECS + ALB for container deployment

yaml
Copy code


---

## ✅ Summary — GitHub Folder Setup Checklist

| Folder/File | Description |
|--------------|-------------|
| `part1_single_ec2/main.tf` | Terraform for single EC2 |
| `part1_single_ec2/user_data.sh` | Installs Flask & Express |
| `part2_two_ec2/` | Two-instance setup |
| `docker/` | Dockerfiles for each app |
| `README.md` | Steps to deploy & test |
| `.gitignore` *(optional)* | ignore `.terraform`, `*.tfstate` |

---

Would you like me to now show **Part 2 EC2 Terraform code** (Flask + Express separate instances with SG connection)?
