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
          agent {
            docker {
              image 'python:3.8'
            }

          }
          steps {
            unstash 'code'
            sh 'pip install -r requirements.txt && python tests.py'
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