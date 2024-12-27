# Jenkins .NET CI/CD Pipeline

This project sets up a Jenkins CI/CD pipeline for .NET applications using Docker containers.

## Prerequisites

- Docker
- Docker Compose
- Git

## Project Structure

```
.
├── Dockerfile              # Jenkins container with .NET SDK
├── docker-compose.yml      # Docker services configuration
├── Jenkinsfile            # CI/CD pipeline definition
└── README.md              # This file
```

## Setup Instructions

1. Clone this repository:
   ```bash
   git clone <repository-url>
   ```

2. Start the Jenkins container:
   ```bash
   docker-compose up -d
   ```

3. Access Jenkins:
   - Open your browser and navigate to `http://localhost:8080`
   - Get the initial admin password from the container:
     ```bash
     docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
     ```

4. Configure Jenkins:
   - Install suggested plugins
   - Create an admin user
   - Configure your Git repository

5. Create a new Pipeline:
   - Click "New Item"
   - Choose "Pipeline"
   - Configure Git repository in the Pipeline section
   - Save and run the pipeline

## Pipeline Stages

1. **Checkout**: Clones the source code
2. **Setup .NET Project**: Creates a new .NET Web API project
3. **Build**: Restores packages and builds the application
4. **Test**: Runs unit tests
5. **Publish**: Creates a production build
6. **Deploy**: Starts the application

## Environment

- Jenkins LTS
- .NET SDK 7.0
- Debian-based container

## Notes

- The application will be accessible on port 5000 after deployment
- Swagger UI will be available at `http://localhost:5000/swagger`
- Jenkins runs on port 8080 