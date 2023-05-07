pipeline {
    agent any
    
    environment {
        registry = "desmondo1/webapp"
        registryCredential = 'docker-hub-creds'
    }
    
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], 
                userRemoteConfigs: [[url: 'https://github.com/Desmondotutu/web_image_test.git']]])
            }
        }

      stage('SonarQube Analysis') {
                def scannerHome = tool 'SonarScanner';
                withSonarQubeEnv() {
                  sh "${scannerHome}/bin/sonar-scanner"
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
