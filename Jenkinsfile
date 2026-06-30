pipeline {
    agent any

    tools {
        jdk 'JDK17'
        maven 'Maven3'
    }

    stages {

        stage('Checkout') {
    steps {
        git branch: 'main',
            credentialsId: 'git-pat',
            url: 'https://github.com/saisureshmatru/terraform-practice.git'
                 }
             }

        stage('Compile') {
            steps {
                sh 'mvn clean compile'
            }
        }

        stage('Package') {
            steps {
                sh 'mvn package'
            }
        }

    }
}
