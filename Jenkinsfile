pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-pat',
                    url: 'https://github.com/saisureshmatru/terraform-practice.git',
                    branch: 'main'
            }
        }
        stage('init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('apply') {
            steps {
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}
