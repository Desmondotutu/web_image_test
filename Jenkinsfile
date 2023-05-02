pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/Desmondotutu-patch-1']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'github-creds', url: 'https://github.com/Desmondotutu/web_image_test.git']]])
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('SonarQube Scan') {
            steps {
                withSonarQubeEnv('My SonarQube Server') {
                    sh 'mvn sonar:sonar'
                }
            }
        }

        stage('Docker Build & Push') {
            steps {
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
