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
          agent {
            docker {
              image 'gradle:jdk11'
            }

          }
          steps {
            sh 'echo hello world'
          }
        }

        stage('unit test') {
          steps {
            unstash 'code'
            sh 'python pip install -r requirements.txt && python tests.py'
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