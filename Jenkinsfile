pipeline {
    agent any  // This tells Jenkins to run this pipeline on any available agent

    stages {
        stage('Checkout') {
            steps {
                // Checks out source code from a source control management system
                checkout scm
            }
        }

        stage('Build') {
            steps {
                // Run the build script
                // Assuming a simple Java project using Maven
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                // Run tests
                // This also assumes using Maven for a Java project
                sh 'mvn test'
            }
            post {
                // Post-condition actions for the 'Test' stage
                always {
                    // Archive the test results
                    junit '**/target/surefire-reports/*.xml'
                }
                success {
                    // Actions to perform if the stage succeeds
                    echo 'Tests passed.'
                }
                failure {
                    // Actions to perform if the stage fails
                    echo 'Tests failed.'
                }
            }
        }

        // Additional stages like 'Deploy', 'Deliver', etc., can be added here
    }

    post {
        // Post-condition actions for the entire pipeline
        always {
            // Actions to perform after the pipeline completes, regardless of the result
            echo 'Pipeline completed.'
        }
        success {
            // Actions to perform if the pipeline succeeds
            echo 'Pipeline succeeded.'
        }
        failure {
            // Actions to perform if the pipeline fails
            echo 'Pipeline failed.'
        }
        // Additional post-conditions like 'changed', 'aborted', etc., can be added here
    }
}
