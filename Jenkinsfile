pipeline {
    agent any

    stages {
        stage('Clonar Repositorio') {
            steps {
                git credentialsId: '9c2c7597-3a34-41c9-aa53-e785cc6c0ad1', url: 'https://github.com/MiltonEduardoHernandez/Minikube_env.git'
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

