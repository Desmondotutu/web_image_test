pipeline {
    agent any
    
    environment {
        registry = "desmondo1/webapp"
        registryCredential = 'dockerhub-creds'
        SCANNER_HOME = tool 'sonar-scanner'
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
                    sh '$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectKey=tester-project -Dsonar.sources=. '
                }
            }
        }
        stage('OWASP DP Check') {
            steps {
             dependencyCheck additionalArguments: ' --scan ./ ', odcInstallation: 'DP-Check'
             dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
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
