pipeline {
    agent any
    stages {

        stage('SCM') {
            steps {
                git branch: 'main', url: 'https://github.com/yashchandane123/app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "/usr/bin/docker image build -t yashchandane/backend ."
            }
        }

        stage("Push Docker Image") {
            steps {
                withCredentials([string(credentialsId: 'DOCKER_HUB_TOKEN', variable: 'DOCKER_HUB_TOKEN')]) {
                    sh "echo $DOCKER_HUB_TOKEN | /usr/bin/docker login -u yashchandane --password-stdin"
                    sh "/usr/bin/docker image push yashchandane/backend"
                }
            }
        }

        stage("Deploy Docker Service") {
            steps {
                script {
                    sh "/usr/bin/docker service rm backend || true"
                }
                sh "/usr/bin/docker service create --name backend -p 4000:4000 --replicas 2 yashchandane/backend"
            }
        }

    }

    post {
        success {
            echo "Pipeline completed successfully!"
        }
        failure {
            echo "Pipeline failed. Please check the logs."
        }
    }
}

