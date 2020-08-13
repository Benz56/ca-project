pipeline {
  agent any
  stages {
    stage('clone down') {
      steps {
        stash(name: 'code', excludes: '.git')
      }
    }

    stage('parallel execution') {
      parallel {
        stage('parallel execution') {
          steps {
            sh 'echo hello world'
          }
        }

        stage('dockerize application') {
          steps {
            sh 'echo hello world'
          }
        }

      }
    }

    stage('push docker') {
      steps {
        sh 'echo hello world'
      }
    }

  }
}