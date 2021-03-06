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
                dir ("./bulletin-board-app") {
                    sh "docker build . -t hoang000147/bulletinboard:${DOCKER_TAG} "
                }
            }
        }
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u hoang000147 -p ${dockerHubPwd}"
                    sh "docker push hoang000147/bulletinboard:${DOCKER_TAG}"
               }
            }
        }
        stage('Deploy to k8s'){
            steps{
                sh "chmod -R 777 changeTag.sh"
                sh "./changeTag.sh ${DOCKER_TAG}"
                sshagent(['vcntt']) {      
                    sh "scp -o StrictHostKeyChecking=no bulletinboarddeploy.yaml vcntt@112.137.141.18:~/bulletin-board/"
                    script{
                        try{
                            sh "ssh vcntt@112.137.141.18 kubectl apply -f ~/bulletin-board/bulletinboarddeploy.yaml"
                        }catch(error){
                            sh "ssh vcntt@112.137.141.18 kubectl create -f ~/bulletin-board/bulletinboarddeploy.yaml"
                        }
                    }
                }
                
                
                //withKubeConfig(caCertificate: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUM4akNDQWRxZ0F3SUJBZ0lJSU04T3h1YnVjZ3N3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB4T1RFeU1ESXdOakkzTkRWYUZ3MHlNREV5TURFd05qSTNORGxhTURReApGekFWQmdOVkJBb1REbk41YzNSbGJUcHRZWE4wWlhKek1Sa3dGd1lEVlFRREV4QnJkV0psY201bGRHVnpMV0ZrCmJXbHVNSUlCSWpBTkJna3Foa2lHOXcwQkFRRUZBQU9DQVE4QU1JSUJDZ0tDQVFFQTRFMzhxQ05uNklLTWZMZnMKbGJFQk9uZGRhMDhHbEZCTVN5V1VHR3RmM3cyRzZOdDVxdXVMM1FUS1F2d2RJRTFoVUFtZGJZRWJ0Q3Y0L1YzeQpEcUN1WEJrc2gxbHNJTXdjZStqZXEyV2k3V0lhUmVUMzNkbXI1dlltUEpHMkNmSkJJVnBVd3lQVHFXREFzL2NYCmd3TSsrNmEwMjcrNTZQbTNtS1BoRVh6amZqS1dqMHFyeUlUeXg5RVNYNjUrREFjU2VyTGlkaWFCaWZyYnAzMGgKZkVrR3l2MWxNV1laUTNkS0tLNm5Wa05YZXdWRldyV1pJNTcyaGhFUlB2VUEwblpHekxMN281VE5PelBXUm05TAplMS83UkZQalFOVXhpRVVCYnlhaEo3VStlaGNTalMvcHRsNk5DZHVaVnZ5MGwrZXV2KzhxdTVRSG9UZ2ZwSG03Ck1Za2NYd0lEQVFBQm95Y3dKVEFPQmdOVkhROEJBZjhFQkFNQ0JhQXdFd1lEVlIwbEJBd3dDZ1lJS3dZQkJRVUgKQXdJd0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFKUUZaMHJtQU9MVm5lcjZPZ0NJMHY0RTkvb3BiOUl3c0xhWgpmNUNMRWlFbzRvM1VjSmZPUHdsT3VjYUF4Q1NSZ0tJY25IbFozbzdtS2RORGlwMEdINGcwV3N6Si9BUGpxeWZJCmptSDhYZ3dYeFdkejBVTE84ejRYZnZReVBkM2krVzlBTzMzbHFadkxJQ1o2WEMrMTdDUHFrVUVERlZSNlExd3MKT1ptM3hxKzB4M3VHa1JldWQ1b29PdjUyMjRzTE9qbzdRL1d6SHRRR0g1REwrUmRUbUl4NnZ1ODZObG8rcEJKSgo1eXd4aGdlQ01Hb1FKdHp3RzRhcnYvNkwxSmdyZk14dXNQbnNpcjJoVUNzZlBHRGhta05uOUhGWUplWTJ4VTBrCnMyQWdaTHRpWEhESStaSFFkeG1id3F2OHZVTDA4UC82UWRueXFzVXh5UXFlRU8xUkdiWT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=', clusterName: 'kubernetes', contextName: 'kubernetes-admin@kubernetes', credentialsId: 'f99d2e73-8627-46ad-8f1a-6fbc5d34b1d7', namespace: 'bulletin-board-test', serverUrl: 'https://112.137.141.18:6443/') {
                    //sh "scp -o StrictHostKeyChecking=no bulletinboarddeploy.yaml vcntt@112.137.141.18:~/bulletin-board/"
                    //sh "ls"
                    //sh "kubectl config view"
                //withKubeConfig(caCertificate: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRFNU1USXdNakEyTWpjME5Wb1hEVEk1TVRFeU9UQTJNamMwTlZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTkFaCmZEQXdadmxpakJBQXdIVk15WmR3dnVGcVN0RWNRYXdFTTZQVFhxSWpUZFFuUGNBUi9pYnZJeFhidXhMd0lNNkcKSjhPZGt4cDNuNTZzRHJveHo3MUpVNFRDMjY1MlFybXpjUlpDcUU2TENrVnZuV1JybjhUclhkRHpBSERuaS9SSQpSZmpQN0dTYUdKeUN4eDdFTVdRWlFUS0VZYzR0dkEyREx1R2lnSE9BUUJXTHFidEt6clgvRnBPRHNVa0VEVnFjCnBDemhDOXBjT2VVb2x4dzVTR296M2FmQkFUYjFSQ3VXYTVNRWFHSStreE5qVmRmR1c0VHBLTkVVM0hQRFBSU08KUTBqMFdqV1cwaGJWRzVNdHRRdmEvL2JhWDN6ZFpRb281cXFHZlRibjU2dk5lMkNnblQ1aGZuTlU4Z0p1Vy9QRgpBYVVKSk9kdEtkSlIzeWUzNjhVQ0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFDbkxGdE9aQ3M5OEN4SEN4cTNHc3RJVGJjbXYKNUVQRGxEWFM5cGQwQWY1bU1EbzRYdUh3Qng2MDVCcUY5WTdXZWMrMkdGOEJSUXZEMUoyOGsrUlBaZ01maDZ3VgpHSWRGbUF3TGZTTjNhRzFyaGNCRTQ2NUNZdlBVYXQ1NDdGcytGQnJGU2FmWHB5ZG1BN0JCQnpXTEFOWnJjWWRtCkM1ZjVhRjgrM3EwUk4vQ0x0SDgzMXJ5cENJSVBDZnF0ZlBQNkNoeXg5dzUwYUdiWUVzbmw3RUhJa3NPVCtwNVEKZXBQY0N5dkhQL2piSWFBcWNHL01wRXBXbUM1VWlEZ25jSElhNGNDckxJcHJweTBLU1J1aVVNUXlOVUgvaHhyegpYc25JQ1lBN3h3a2tIa2JsVTRpQnFDMWxXQ1JlT0RmOVBlMjllWUxxQlZ0bFY3SEc3QlV5Nmllb2Jucz0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=', clusterName: 'kubernetes', contextName: 'kubernetes-admin@kubernetes', credentialsId: 'f99d2e73-8627-46ad-8f1a-6fbc5d34b1d7', namespace: 'default', serverUrl: 'https://112.137.141.18:6443/') {
                /*withKubeConfig(caCertificate: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRFNU1USXdNakEyTWpjME5Wb1hEVEk1TVRFeU9UQTJNamMwTlZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTkFaCmZEQXdadmxpakJBQXdIVk15WmR3dnVGcVN0RWNRYXdFTTZQVFhxSWpUZFFuUGNBUi9pYnZJeFhidXhMd0lNNkcKSjhPZGt4cDNuNTZzRHJveHo3MUpVNFRDMjY1MlFybXpjUlpDcUU2TENrVnZuV1JybjhUclhkRHpBSERuaS9SSQpSZmpQN0dTYUdKeUN4eDdFTVdRWlFUS0VZYzR0dkEyREx1R2lnSE9BUUJXTHFidEt6clgvRnBPRHNVa0VEVnFjCnBDemhDOXBjT2VVb2x4dzVTR296M2FmQkFUYjFSQ3VXYTVNRWFHSStreE5qVmRmR1c0VHBLTkVVM0hQRFBSU08KUTBqMFdqV1cwaGJWRzVNdHRRdmEvL2JhWDN6ZFpRb281cXFHZlRibjU2dk5lMkNnblQ1aGZuTlU4Z0p1Vy9QRgpBYVVKSk9kdEtkSlIzeWUzNjhVQ0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFDbkxGdE9aQ3M5OEN4SEN4cTNHc3RJVGJjbXYKNUVQRGxEWFM5cGQwQWY1bU1EbzRYdUh3Qng2MDVCcUY5WTdXZWMrMkdGOEJSUXZEMUoyOGsrUlBaZ01maDZ3VgpHSWRGbUF3TGZTTjNhRzFyaGNCRTQ2NUNZdlBVYXQ1NDdGcytGQnJGU2FmWHB5ZG1BN0JCQnpXTEFOWnJjWWRtCkM1ZjVhRjgrM3EwUk4vQ0x0SDgzMXJ5cENJSVBDZnF0ZlBQNkNoeXg5dzUwYUdiWUVzbmw3RUhJa3NPVCtwNVEKZXBQY0N5dkhQL2piSWFBcWNHL01wRXBXbUM1VWlEZ25jSElhNGNDckxJcHJweTBLU1J1aVVNUXlOVUgvaHhyegpYc25JQ1lBN3h3a2tIa2JsVTRpQnFDMWxXQ1JlT0RmOVBlMjllWUxxQlZ0bFY3SEc3QlV5Nmllb2Jucz0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=', clusterName: '', contextName: '', credentialsId: 'jenkins-credentials', namespace: '', serverUrl: 'https://112.137.141.18:6443/') {
                    sh "kubectl get pods -n cicd"
                    script{
                        try{
                            sh "kubectl apply -f bulletinboarddeploy.yaml"
                        }catch(error){
                            sh "kubectl create -f bulletinboarddeploy.yaml"
                        }
                    }
                }*/
            }
        }
    }
}

def getDockerTag(){
    def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}
