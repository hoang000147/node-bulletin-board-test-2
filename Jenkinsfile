pipeline {
    agent {
        docker {
            image 'node:6-alpine'
            args '-p 30005:8080'
        }
    }
    
    environment {
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
                dir("./bulletin-board-app") {
                    sh "pwd"
                    sh 'ls'
                    sh 'npm install'
                }
                //sh 'ls'
                //sh 'npm install'
            }
        }
        
        /*stage('Deploy') {
            steps {
                sh './deployment.sh'
            }
        }*/
    }
}
