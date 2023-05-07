pipeline {
    agent any
    
    environment {
        registry = "desmondo1/webapp"
        registryCredential = 'docker-hub-creds'
    }
    tools {
        sonarScanner 'sonar-scanner'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], 
                userRemoteConfigs: [[url: 'https://github.com/Desmondotutu/web_image_test.git']]])
            }
        }

        stage('Static Code Analysis') {
          steps {
            withSonarQubeEnv('sonar-server') {
              sh 'sonar-scanner -Dsonar.projectKey=tester-project -Dsonar.projectName=tester-project -Dsonar.projectVersion=1.0 -Dsonar.sources=. -Dsonar.language=web -Dsonar.sourceEncoding=UTF-8 -Dsonar.html.reportPaths=reports/sonar/html -Dsonar.css.reportPaths=reports/sonar/css'
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
