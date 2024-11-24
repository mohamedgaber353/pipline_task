# Node.js Application Docker Deployment with GitHub Actions

This project is a GitHub Actions workflow setup that automates the process of building, pushing, and deploying a Dockerized Node.js application to an EC2 instance.

## Table of Contents
1. [Overview](#overview)
2. [Project Structure](#project-structure)
3. [Workflow Stages](#workflow-stages)
4. [Pre-requisites](#pre-requisites)
5. [Setup Instructions](#setup-instructions)
6. [EC2 Configuration](#ec2-configuration)
7. [Troubleshooting](#troubleshooting)
8. [Screenshot](#screenshot)

## Overview
This GitHub Actions workflow automates the following tasks:
- **Checkout**: Pulls the latest code from the repository.
- **Build Docker Image**: Builds a Docker image of the Node.js application.
- **Docker Login**: Authenticates with Docker Hub using stored secrets.
- **Push Docker Image**: Pushes the built Docker image to Docker Hub.
- **Deploy Application**: Deploys the Docker image to an EC2 instance using SSH, handling any conflicts with port allocation by removing existing containers.

## Project Structure
- `Dockerfile`: Defines the Docker image for the Node.js application.
- `.github/workflows/docker-pipeline.yml`: The GitHub Actions workflow file.
- `src/`: Directory containing the source code for the Node.js application.

## Workflow Stages

### 1. Checkout Code
This stage uses the GitHub-provided `actions/checkout` to pull the latest code from the repository.

### 2. Build Docker Image
The workflow builds the Docker image for the Node.js application using the Dockerfile located in the repository's root. The image is tagged with the GitHub Actions run number.

### 3. Docker Login
This stage logs in to Docker Hub using secrets stored in the repository (`DOCKER_USERNAME` and `DOCKER_PASSWORD`).

### 4. Push Docker Image
After logging in, the workflow pushes the Docker image to Docker Hub with a unique tag based on the workflow run number.

### 5. Deploy Application
This stage deploys the Docker image to an EC2 instance by SSH-ing into the EC2 instance and running the Docker container. It removes any existing container using the specified port before starting the new container.

## Pre-requisites
1. **Docker**: Ensure Docker is installed and configured on the EC2 instance.
2. **GitHub Repository Secrets**:
   - `DOCKER_USERNAME`: Your Docker Hub username.
   - `DOCKER_PASSWORD`: Your Docker Hub password or access token.
   - `EC2_SSH_KEY`: The private SSH key for accessing your EC2 instance.
3. **EC2 Instance**: An EC2 instance running and accessible for SSH.

## Setup Instructions

### 1. Workflow Configuration
- Create a `.github/workflows/docker-pipeline.yml` file in your repository.
- Add the GitHub Actions workflow provided in this project.

### 2. Add Secrets to GitHub
- Go to your GitHub repository, then **Settings > Secrets and variables > Actions**.
- Add the following secrets:
  - `DOCKER_USERNAME`: Your Docker Hub username.
  - `DOCKER_PASSWORD`: Your Docker Hub password or access token.
  - `EC2_SSH_KEY`: Your EC2 private key file content.

### 3. Push Changes
- Commit and push the workflow file and other project files to your GitHub repository.

## EC2 Configuration
1. Ensure Docker is installed and running on your EC2 instance.
   - Install Docker using `sudo apt install docker.io` or equivalent for your OS.
2. Open the required port (e.g., 3050) in the EC2 instance's security group.
   - Navigate to **Security Groups > Edit inbound rules** in the AWS Console and add a custom TCP rule for the desired port.
3. Ensure the EC2 instance is accessible via SSH using the provided key.

## Troubleshooting

### Port Conflict Error
If you encounter an error like:
The workflow handles this by stopping and removing any existing container running on the specified port.

### Docker Login Failures
Ensure your Docker Hub credentials (`DOCKER_USERNAME` and `DOCKER_PASSWORD`) are correctly set in the GitHub repository secrets.

### SSH Connection Failures
Verify that:
- The `EC2_SSH_KEY` is correctly added as a GitHub secret.
- The EC2 instance's public IP or DNS is accessible.
- The correct port (default: 22) is open in the EC2 security group.

## Screenshot
Here is a screenshot of the application:

![Application Screenshot](https://github.com/mohamedgaber353/pipline_task/blob/main/Screenshot%202024-11-25%20005736.png)
