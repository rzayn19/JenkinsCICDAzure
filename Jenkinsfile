pipeline {
    agent any
    stages {
        stage('Terraform Init') {
            steps {
                withCredentials([azureServicePrincipal('AZURE_CREDENTIALS')]) {
                    sh 'terraform init'
                }
            }
        }
        stage('Terraform Plan') {
            steps {
                withCredentials([azureServicePrincipal('AZURE_CREDENTIALS')]) {
                    sh 'terraform plan'
                }
            }
        }
        stage('Terraform Apply') {
            steps {
                withCredentials([azureServicePrincipal('AZURE_CREDENTIALS')]) {
                    sh 'terraform apply -auto-approve'
                }
            }
        }
    }
}
