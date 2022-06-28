pipeline {
    agent any
    stages {
        stage('Build Docker') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhubpwd', passwordVariable: 'dockerpwd', usernameVariable: 'dockerusername')]) {
                        checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/patricktrp/ci-cd-master.git']]])
                        sh 'docker build -t ${dockerusername}/ci-cd-master:$BUILD_NUMBER .'
                    }
                }
            }
        }
        stage('Push to Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhubpwd', passwordVariable: 'dockerpwd', usernameVariable: 'dockerusername')]) {
                        sh 'docker login -u ${dockerusername} -p ${dockerpwd}'
                        sh 'docker push ${dockerusername}/ci-cd-master:$BUILD_NUMBER'
                    }
                }
            }
        }
        stage('Trigger Manifest Update') {
            steps{
                def buildnum = '$BUILD_NUMBER'
            build job: 'updatemanifest', parameters: [string(name: 'DOCKERTAG', value: buildnum)]
            }
        }
    }
}
