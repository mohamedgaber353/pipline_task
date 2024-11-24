pipeline {
    agent any
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/mohamedgaber353/pipline_task.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Use bash explicitly for compatibility
                    sh '''
                        #!/bin/bash
                        docker build -t mohamedgaber353/nodjs:${BUILD_NUMBER} .
                    '''
                }
            }
        }
        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'mohamed-docker', usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
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
                        docker push mohamedgaber353/nodjs${BUILD_NUMBER}
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
                            chmod 400 $SSH_KEY
                            ssh -i $SSH_KEY -o StrictHostKeyChecking=no ec2-user@ec2-52-73-65-200.compute-1.amazonaws.com "
                            docker rm -f gaber
                            docker run -d --name gaber  -p 3050:3000 elshoky/nodjs:${BUILD_NUMBER}"
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
