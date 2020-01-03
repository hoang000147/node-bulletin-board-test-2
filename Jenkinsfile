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
                sh 'cd ./bulletin-board-app/'
                sh 'ls'
                sh 'npm install'
            }
        }
        
        /*stage('Deploy') {
            steps {
                sh './deployment.sh'
            }
        }*/
    }
}
