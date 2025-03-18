pipeline {
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    jenkins-agent: docker
spec:
  containers:
  - name: docker
    image: docker:20.10.7-dind
    securityContext:
      privileged: true
    tty: true
    volumeMounts:
      - mountPath: /var/lib/docker
        name: docker-storage
  - name: jnlp
    image: jenkins/inbound-agent
    args: ['']
  volumes:
  - name: docker-storage
    emptyDir: {}
"""
        }
    }
    stages {
        stage('Clonar Repositorio') {
            steps {
                git branch: 'main', credentialsId: 'TU_CREDENCIAL_ID', url: 'https://github.com/MiltonEduardoHernandez/Minikube_env.git'
            }
        }

        stage('Construir Imagen Docker') {
            steps {
                container('docker') {
                    sh 'docker build -t my-app .'
                }
            }
        }

        stage('Ejecutar Contenedor') {
            steps {
                container('docker') {
                    sh 'docker run -d --name my-app -p 8080:8080 my-app'
                }
            }
        }
    }

    post {
        always {
            container('docker') {
                sh 'docker stop my-app || true'
                sh 'docker rm my-app || true'
            }
        }
    }
}

