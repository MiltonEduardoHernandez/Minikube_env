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
    image: docker:24.0.5-dind
    securityContext:
      privileged: true
    tty: true
    volumeMounts:
      - mountPath: /var/lib/docker
        name: docker-storage
  - name: jnlp
    image: jenkins/inbound-agent
    args: ['']
    securityContext:
      runAsUser: 1000
      allowPrivilegeEscalation: true
  volumes:
  - name: docker-storage
    emptyDir: {}
"""
        }
    }

    environment {
        IMAGE_NAME = "my-app"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Clonar Repositorio') {
            steps {
                script {
                    echo "Clonando el repositorio..."
                    checkout scm
                }
            }
        }

        stage('Construir Imagen Docker') {
            steps {
                container('docker') {
                    script {
                        echo "Construyendo imagen Docker..."
                        sh '''
                        set -e
                        docker build -t $IMAGE_NAME:$IMAGE_TAG .
                        '''
                    }
                }
            }
        }

        stage('Ejecutar Contenedor') {
            steps {
                container('docker') {
                    script {
                        echo "Ejecutando contenedor..."
                        sh '''
                        docker stop my-app || true
                        docker rm my-app || true
                        docker run -d --name my-app -p 8080:8080 $IMAGE_NAME:$IMAGE_TAG
                        '''
                    }
                }
            }
        }

        stage('Probar Aplicación') {
            steps {
                container('docker') {
                    script {
                        echo "Esperando que la aplicación inicie..."
                        sleep 5
                        echo "Verificando que el servicio responde..."
                        sh '''
                        curl -f http://localhost:8080 || exit 1
                        '''
                    }
                }
            }
        }
    }

    post {
    always {
        container('docker') {
            script {
                echo "Limpiando contenedores y volúmenes..."
                sh '''
                docker stop my-app || true
                docker rm my-app || true
                docker volume prune -f || true
                '''
            }
        }
        cleanWs()
    }
}
}