pipeline {
    agent any

    stages {
        stage('Clonar') {
            steps {
                git 'https://github.com/tu-usuario/my-spring-app.git'
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

