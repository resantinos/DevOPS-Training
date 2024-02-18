pipeline {
    agent any

    stages {
        stage('Install Docker') {
            steps {
                script {
                    // Check if Docker is already installed
                    if (sh(script: 'which docker', returnStatus: true) != 0) {
                        // Installing Docker
                        echo 'Docker is not installed. Installing...'
                        sh 'curl -fsSL https://get.docker.com -o get-docker.sh'
                        sh 'sh get-docker.sh'
                        
                        // Optionally, add the Jenkins user or the default running user to the Docker group
                        // Be aware of security implications
                        sh 'sudo usermod -aG docker $USER'
                        
                        // Start Docker service if necessary
                        sh 'sudo systemctl start docker'
                    } else {
                        echo 'Docker is already installed.'
                    }
                }
            }
        }
        stage('Verify Docker Installation') {
            steps {
                // Verify Docker installation by running a simple Docker command
                sh 'docker --version'
            }
        }
    }
}
