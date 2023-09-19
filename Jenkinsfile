pipeline {
  agent any
  stages {
    stage('Test') {
      agent {
        docker {
          image 'maven:3.9.4-eclipse-temurin-17'
          args '-v /root/.m2:/root/.m2'
        }
      }
      steps {
        sh 'mvn test'
      }
      post {
        always {
          script {
            def workspacePath = env.WORKSPACE
            archiveArtifacts artifacts: "target/karate-reports/", allowEmptyArchive: true
          }
        }
      }
    }
  }
}