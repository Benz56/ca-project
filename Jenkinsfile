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
            unstash 'code'
            sh 'mkdir -p archive'
            sh 'echo run.py > archive/run.py'
            sh 'echo requirements.txt > archive/requirements.txt'
            sh 'cp app/* archive/app/'
            script {
              zip archive: true, dir: 'archive', glob:'', zipFile: 'codechan.zip'
            }

            archiveArtifacts 'codechan.zip'
            stash 'code'
          }
        }

        stage('dockerize application') {
          agent {
            docker {
              image 'gradle:jdk11'
            }

          }
          steps {
            unstash 'code'
            sh 'chmod +x ci/build-docker.sh'
            stash 'code'
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
      when {
        branch 'master'
      }
      environment {
        DOCKERCREDS = credentials('docker_login')
      }
      steps {
        unstash 'code'
        sh 'chmod +x ci/push-docker.sh'
      }
    }

    stage('dancing man') {
      steps {
        sh 'echo look at me I\'m dancing, I\'m danicng!'
      }
    }

  }
  environment {
    docker_username = 'benz56'
  }
}