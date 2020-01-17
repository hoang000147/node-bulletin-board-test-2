/*pipeline {
    agent {
        docker {
            image 'node:6.11.5'
            args '-p 30006:8075'
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
                    //sh 'npm start'
                    sh './deployment.sh'
                    input message: 'Finished using the web site? (Click "Proceed" to continue)'
                    sh './kill.sh'
                }
            }
        }
    }
}*/


pipeline {
    agent any
    environment{
        DOCKER_TAG = getDockerTag()
    }
    stages{
        stage('Build Docker Image'){
            steps{
                sh "docker build . -t hoang000147/bulletinboard:${DOCKER_TAG} "
            }
        }
        stage('DockerHub Push'){
            steps{
                //withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u hoang000147 -p doinhuloz"
                    sh "docker push hoang000147/bulletinboard:${DOCKER_TAG}"
               // }
            }
        }
        stage('Deploy to k8s'){
            steps{
                sh "chmod -R 777 changeTag.sh"
                sh "./changeTag.sh ${DOCKER_TAG}"
                sshagent(['vcntt']) {
                    sh "scp -o StrictHostKeyChecking=no bulletinboarddeploy.yaml vcntt@112.137.141.18:/bulletin-board/"
                    script{
                        try{
                            sh "ssh vcntt@112.137.141.18 kubectl apply -f ."
                        }catch(error){
                            sh "ssh vcntt@112.137.141.18 kubectl create -f ."
                        }
                    }
                }
            }
        }
    }
}

def getDockerTag(){
    def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}
