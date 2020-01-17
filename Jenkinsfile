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
        /*stage('Deploy to k8s'){
            steps{
                sh "chmod -R 777 changeTag.sh"
                sh "./changeTag.sh ${DOCKER_TAG}"
                sshagent(['kops-machine']) {
                    sh "scp -o StrictHostKeyChecking=no services.yml node-app-pod.yml ec2-user@52.66.70.61:/home/ec2-user/"
                    script{
                        try{
                            sh "ssh ec2-user@52.66.70.61 kubectl apply -f ."
                        }catch(error){
                            sh "ssh ec2-user@52.66.70.61 kubectl create -f ."
                        }
                    }
                }
            }
        }*/
    }
}

def getDockerTag(){
    def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}
