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
            sh 'mkdir -p archive/app'
            sh 'mkdir -p archive/db_repository'
            sh 'cp app.db archive/'
            sh 'cp create_db.py archive/'
            sh 'cp downgrade_down.py archive/'
            sh 'cp migrate_db.py archive/'
            sh 'cp upgrade_db.py archive/'
            sh 'cp config.py archive/'
            sh 'cp run.py archive/'
            sh 'cp requirements.txt archive/'
            sh 'cp -r app/* archive/app/'
            sh 'cp -r db_repository/* archive/db_repository/'
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
            stash 'code'
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
        sh 'echo "$DOCKERCREDS_PSW" | docker login -u "$DOCKERCREDS_USR" --password-stdin'
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