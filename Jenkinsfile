pipeline {
    agent {
        docker {
            image 'node:6.11.5'
            args '-p 30005:8080'
        }
    }
    
    environment {
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
                sh './bulletin-board-app/deployment.sh'
                dir("./bulletin-board-app") {
                    sh "pwd"
                    sh 'npm install'
                    sh 'ls'
                    sh './bulletin-board-app/deployment.sh'
                }
                //sh 'ls'
                //sh 'npm install'
            }
        }
        
        /*stage('Deploy') {
            steps {
                dir ("./bulletin-board-app") {
                    sh 'deployment.sh'
                }        
            }
        }*/
    }
}
