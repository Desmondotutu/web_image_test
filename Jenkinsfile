pipeline {
    agent any
    
    environment {
        registry = "desmondo1/webapp"
        registryCredential = 'docker-hub-creds'
    }
    tools {
        SonarScanner 'SonarScanner'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], 
                userRemoteConfigs: [[url: 'https://github.com/Desmondotutu/web_image_test.git']]])
            }
        }

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarServer') {
                    sh 'SonarScanner \
                    -Dsonar.projectKey=tester-project \
                    -Dsonar.sources=. \
                }
            }
        }
        
        stage('Docker Build & Push') {
            steps {
                script {
                    def dockerImage = docker.build("${registry}:${env.BUILD_NUMBER}", "-f Dockerfile .")
                    docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
    }
}
