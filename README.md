# Infrastructure deployment exercise


## Terraform Automation for AWS Application Deployment

This repository contains Terraform code to automate the deployment of an application in AWS. The infrastructure includes two t2.nano EC2 instances behind an Application Load Balancer (ALB) on port 80, along with an RDS instance using the MySQL engine.

### Assumptions

1. This Terraform configuration assumes the use of a Linux-based Amazon Machine Image (AMI) for the EC2 instances. Please replace the `ami` attribute in the Launch Template resource with the appropriate AMI ID for your desired Linux distribution.

2. The RDS instance is configured to use the MySQL engine. If you want to use a different database engine, please modify the `engine` attribute in the `aws_db_instance` resource accordingly.

### Prerequisites

1. Install Terraform: Make sure you have Terraform installed on your machine. Refer to the [Terraform installation guide](https://learn.hashicorp.com/tutorials/terraform/install-cli) for instructions.

2. AWS Account: You need an AWS account to deploy the infrastructure. Ensure you have the necessary access permissions and AWS credentials configured on your machine.

### Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/example/terraform-app.git
   cd terraform-app
   ```

2. Initialize the Terraform configuration:
   ```bash
   terraform init
   ```

3. Modify the `main.tf` file if necessary:
   - Replace placeholder values such as `region`, `subnet-ids`, `vpc-id`, `launch-template-id`, and `db-subnet-group-name` with the appropriate values for your AWS environment.

4. Deploy the infrastructure:
   ```bash
   terraform apply
   ```

   Review the planned changes and enter `yes` to proceed with the deployment.

5. After the deployment is complete, the Terraform output will display the DNS name of the ALB. You can use this DNS name to access the service from a future application.

### Continuous Deployment Considerations

To incorporate this Terraform automation into a Continuous Deployment (CD) pipeline, the following considerations should be made:

- **Infrastructure as Code**: Store the Terraform configuration in a version control system (e.g., Git) to track changes, enable collaboration, and facilitate code reviews before applying changes to production.

- **Secrets Management**: Avoid storing sensitive information directly in the Terraform configuration. Instead, use a secrets management system or environment variables to securely pass sensitive values such as passwords or access keys.

- **Variable Management**: Use Terraform variables to parameterize the configuration, enabling different environments (e.g., development, staging, production) to be provisioned using the same codebase with different variable values.

- **Automated Testing and Validation**: Implement automated tests to validate the infrastructure changes before applying them to the production environment. This may include syntax checks, linting, and integration tests.

- **Approval Process**: Establish an approval process within the CD pipeline to ensure that changes to the infrastructure are reviewed and approved before being deployed to production.

- **Deployment Strategy**: Define a deployment strategy that suits your application's requirements, such as rolling updates, blue-green deployments, or canary releases, to minimize downtime and ensure a smooth transition.

By considering these aspects, you can safely and successfully deploy the Terraform code into production as part of a CD pipeline.

### Cleanup

To clean up the resources created by Terraform and destroy the infrastructure, run the following command:

```bash
terraform destroy
```

Review the planned actions and enter `yes` to proceed with the destruction.

**Note:** Be cautious while running the destroy command as it will permanently delete the provisioned infrastructure.

For more information on Terraform commands and usage,

 refer to the [Terraform documentation](https://www.terraform.io/docs/cli-index.html).

If you have any further questions or need assistance, please feel free to reach out.