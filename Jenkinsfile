pipeline {
    agent any

    stages {
        stage('Checkout') {
            step {
                git url: 'https://github.com/Desmondotutu/web_image_test.git'
            }
        }

        stage('SonarQube Scan') {
            step {
                withSonarQubeEnv('My SonarQube Server') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Docker Build & Push') {
            step {
                script {
                    def app = docker.build("desmondo1/webapp:${env.BUILD_NUMBER}")
                    app.tag("desmondo1/webapp:tagname")
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-creds') {
                        app.push()
                    }
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
