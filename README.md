# Weather Alert System

This project is a full-stack, containerized weather alert system that includes:

- **Backend:** FastAPI with SNS integration for alert notifications.
- **Frontend:** A simple creat React application displaying weather alerts.
- **Infrastructure:** Provisioned via Terraform for both local (LocalStack) and production (AWS) environments.
- **Kubernetes Deployments:** Managed via Helm (using kind for local and EKS for production).
- **CI/CD:** Automated via CircleCI with Terraform linting, planning, and deployment.
- **Monitoring:** Includes CloudWatch metrics and alarms, with Prometheus and Grafana for observability.
