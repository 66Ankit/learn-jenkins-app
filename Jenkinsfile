pipeline {
    agent any

    environment {
        NETLIFY_SITE_ID = '74ecaabb-fe6e-4ea2-8623-cabed9432b02'
        NETLIFY_AUTH_TOKEN = credentials('netlify-token')
    }

    stages {
        stage('Build') {
            agent {
                docker{
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    ls -la
                    node --version
                    npm --version
                    npm ci
                    npm run build
                    ls -la
                '''
            }
        }
        stage("Test"){
            agent{
                docker{
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps{
                sh'''
                    test -f build/index.html
                    npm test
                '''
            }
        }
        stage('Deploy') {
            agent {
                docker {
                    image 'node:18-alpine'
                    reuseNode true
                }
            }
            steps {
                sh '''
                    npm netlify --version
                    echo "deploying to production site ID : $NETLIFY_SITE_ID"
                    node_modules/.bin/netlify status
                    node_modules/.bin/netlify deploy --dir=build --prod
                    echo "small change"

                '''
            }

        }
    }
    post{
        always {
            junit 'test-results/junit.xml'

        }
    }
}
