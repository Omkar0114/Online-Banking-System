pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        checkout scm
        sh 'bundle install'
      }
    }

    stage('Test') {
      steps {
        sh 'bundle exec rspec'
      }
      post {
        always {
          junit 'spec/reports/*.xml'
        }
      }
    }

    stage('Deploy') {
      environment {
        SSH_KEY = credentials('SSH_KEY')
        REMOTE_HOST = 'example.com'
        REMOTE_USER = 'user'
        REMOTE_PATH = '/var/www/myapp'
      }
      steps {
        withCredentials([sshUserPrivateKey(credentialsId: 'SSH_KEY', keyFileVariable: 'SSH_KEY')]) {
          sh '''
            ssh -o StrictHostKeyChecking=no -i $SSH_KEY $REMOTE_USER@$REMOTE_HOST \
              "cd $REMOTE_PATH && git pull && bundle install --deployment && touch tmp/restart.txt"
          '''
        }
      }
    }
  }
}
