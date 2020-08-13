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
        stage('create artifact') {
          steps {
            sh 'echo hello world'
          }
        }

        stage('dockerize application') {
          steps {
            sh 'echo hello world'
          }
        }

        stage('unit test') {
          steps {
            unstash 'code'
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