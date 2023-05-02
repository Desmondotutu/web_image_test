pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Desmondotutu/web_image_test.git',
                    branch: 'main'
            }
        }

        stage('SonarQube Scan') {
            steps {
                withSonarQubeEnv('Sonarqube-Server') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

    stage('Docker Build & Push') {
        steps {
            script {
                def registry = "desmondo1/webapp"
                def dockerImage = docker.build(registry + ":${env.BUILD_NUMBER}", "-f Dockerfile .")
                docker.withRegistry('https://registry.hub.docker.com', 'dockerhub-creds') {
                    dockerImage.push("${env.BUILD_NUMBER}")
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }

        success {
            echo 'Successfully built and deployed Docker image'
        }

        failure {
            echo 'Build failed'
        }
    }
}
