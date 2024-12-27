pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Clones from the repository configured in Jenkins
                checkout scm
            }
        }

        stage('Setup .NET Project') {
            steps {
                sh '''
                    # Remove existing dotnet directory and create new project
                    rm -rf dotnet
                    mkdir dotnet
                    cd dotnet
                    
                    # Create new .NET Web API project
                    dotnet new webapi
                    
                    # Add common packages
                    dotnet add package Microsoft.EntityFrameworkCore
                    dotnet add package Microsoft.EntityFrameworkCore.SqlServer
                    dotnet add package Microsoft.EntityFrameworkCore.Design
                    dotnet add package Swashbuckle.AspNetCore
                '''
            }
        }

        stage('Build') {
            steps {
                sh '''
                    cd dotnet
                    dotnet restore
                    dotnet build --configuration Release --no-restore
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    cd dotnet
                    dotnet test --no-restore --verbosity normal
                '''
            }
        }

        stage('Publish') {
            steps {
                sh '''
                    cd dotnet
                    dotnet publish -c Release -o ./publish
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    cd dotnet
                    dotnet ./publish/dotnet.dll --urls "http://0.0.0.0:5000" &
                '''
            }
        }
    }
} 