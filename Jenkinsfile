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
                dir("./bulletin-board-app") {
                    //sh "pwd"
                    sh 'npm install'
                }
            }
        }
        
        stage('Deploy') {
            steps {                
                dir("./bulletin-board-app") {
                    sh 'chmod 777 -R .'
                    sh './deployment.sh'
                    input message: 'Finished using the web site? (Click "Proceed" to continue)'
                    sh './kill.sh'
                }
            }
        }
    }
}
