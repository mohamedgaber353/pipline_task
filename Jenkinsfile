pipeline {
    agent any

    environment {
        DOCKERHUB = 'mohamedgaber353'
        IMAGE_TAG = "${BUILD_ID}"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/mohamedgaber353/pipline_task.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image
                    sh '''
                        #!/bin/bash
                        docker build -t ${DOCKERHUB}/app:${IMAGE_TAG} .
                    '''
                }
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker_hub', usernameVariable: 'USER', passwordVariable: 'PASSWORD')]) {
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
                    // Push Docker image
                    sh '''
                        #!/bin/bash
                        docker push ${DOCKERHUB}/app:${IMAGE_TAG}
                    '''
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
