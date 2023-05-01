pipeline {
    agent any
    
    environment {
    TF_CLI_ARGS = "-no-color"
     subscription_id = credentials('AZURE_CREDENTIALS')
     client_id      = credentials('AZURE_CREDENTIALS')
     client_secret  = credentials('AZURE_CREDENTIALS')
      tenant_id     = credentials('AZURE_CREDENTIALS')
}

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                    sh 'terraform init'
                }
        }

        stage('Terraform Plan') {
            steps {
                    withCredentials([azureServicePrincipal('AZURE_CREDENTIALS')]) {
                        sh "terraform plan -var 'client_id=${env.AZURE_CLIENT_ID}' -var 'client_secret=${env.AZURE_CLIENT_SECRET}' -var 'subscription_id=${env.AZURE_SUBSCRIPTION_ID}' -var 'tenant_id=${env.AZURE_TENANT_ID}'"
                    }
                }
        }

        stage('Terraform Apply') {
            steps {
                    withCredentials([azureServicePrincipal('AZURE_CREDENTIALS')]) {
                        sh "terraform apply -auto-approve -var 'client_id=${env.AZURE_CLIENT_ID}' -var 'client_secret=${env.AZURE_CLIENT_SECRET}' -var 'subscription_id=${env.AZURE_SUBSCRIPTION_ID}' -var 'tenant_id=${env.AZURE_TENANT_ID}'"
                    }
}
}
}
}
