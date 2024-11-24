pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Use bash explicitly for compatibility
                    sh '''
                        #!/bin/bash
                        docker build -t elshoky/nodjs-app:${BUILD_NUMBER} .
                    '''
                }
            }
        }
        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-elshoky', usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
                    script {
                        // Login to Docker
                        sh '''
                            #!/bin/bash
                            echo "$PASSWORD" | docker login -u "$USER" --password-stdin
                        '''
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    // Push the Docker image
                    sh '''
                        #!/bin/bash
                        docker push elshoky/nodjs-app:${BUILD_NUMBER}
                    '''
                }
            }
        }
        stage('Deploy Application') {
            steps {
                script {
                    // Use the SSH key to connect to the EC2 instance and deploy the Docker container
                    withCredentials([file(credentialsId: 'ssh-key-ec2', variable: 'SSH_KEY')]) {
                        sh '''
                            #!/bin/bash
                            # Make sure the private key has the correct permissions
                            chmod 400 $SSH_KEY
                            # Print Docker image name for debugging
                            echo "Docker image: elshoky/nodjs-app:${BUILD_NUMBER}"
        
                            # Connect to EC2 via SSH and run the Docker container
                            ssh -i $SSH_KEY -o StrictHostKeyChecking=no ec2-user@ec2-52-73-65-200.compute-1.amazonaws.com "
                            #stop & remove the container before run container for checking!
                            docker stop elshoky-app
                            docker rm elshoky-app
                            docker run -d --name elshoky-app  -p 3037:3000 elshoky/nodjs-app:${BUILD_NUMBER}"
                            docker container prune -f
                        '''
                    }
                }
            }
        }
    }
    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}
