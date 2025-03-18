pipeline {
    agent any

    stages {
        stage('Clonar Repositorio') {
            steps {
                git branch: 'main', credentialsId: 'token', url: 'https://github.com/MiltonEduardoHernandez/Minikube_env.git'
            }
        }

        stage('Construir Docker') {
            steps {
                script {
                    // Construir la imagen Docker
                    sh 'docker build -t my-app .'
                }
            }
        }

        stage('Ejecutar Docker') {
            steps {
                script {
                    // Ejecutar la imagen Docker
                    sh 'docker run -d -p 8080:8080 my-app'
                }
            }
        }
    }

    post {
        always {
            cleanWs() // Limpiar el workspace después del job
        }
    }
}

