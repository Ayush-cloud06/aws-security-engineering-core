# 🛡️ Amazon Inspector – Organization Control Plane

This folder implements **Amazon Inspector** as an organization-wide vulnerability management system using Terraform.  
It is designed to run from the **Inspector Delegated Admin Account** and acts as the vulnerability detection layer of the security platform.

Inspector discovers:
- OS & package vulnerabilities on EC2
- Container image vulnerabilities in ECR
- Lambda package and code vulnerabilities

Findings are later forwarded into **AWS Security Hub** for centralized governance.

---