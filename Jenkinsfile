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
                //sh './bulletin-board-app/deployment.sh'
                dir("./bulletin-board-app") {
                    sh "pwd"
                    sh 'npm install'
                    //sh 'npm start'
                    //sh 'ls'
                    //sh './bulletin-board-app/deployment.sh'
                }
                sh 'ls ./bulletin-board-app/'
                //sh 'npm install'
            }
        }
        
        stage('Deploy') {
            steps {
                echo './bulletin-board-app/deployment.sh'
                sh 'chmod 777 -R ./bulletin-board-app/'
                sh './bulletin-board-app/deployment.sh'  
            }
        }
    }
}
