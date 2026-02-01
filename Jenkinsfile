pipeline {
    agent { label 'k8s-Node-1' }
    tools{
        maven 'mymaven'
    }
    environment {
        // Set JAVA_HOME to Java 17 (verified path from k8s-Node-1)
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64'
        PATH = "/usr/lib/jvm/java-17-openjdk-amd64/bin:${env.PATH}"
    }
    stages{
        stage('Check Environment'){
            steps{
                script {
                    echo "=== Current Java Configuration ==="
                    sh 'java -version'
                    sh 'echo "JAVA_HOME: $JAVA_HOME"'
                    sh 'echo "PATH: $PATH"'
                    echo "=== Available Java Installations ==="
                    sh 'ls -la /usr/lib/jvm/ || echo "JVM directory not found"'
                    sh 'update-alternatives --list java || echo "update-alternatives not available"'
                    echo "=== Maven Configuration ==="
                    sh 'mvn -version'
                }
            }
        }
        stage('Cloning Code'){
            steps{
                git url:'https://github.com/Manjunath-Proj/spring-boot-application.git', branch: "main"
              
            }
        }
        stage('Compile the code'){
            steps{
                sh 'mvn compile'
            }
        }
        stage('Review Code'){
            steps{   // build steps
                sh 'mvn pmd:pmd'   // xml report is generated 
            }
            post{   // post build action
                success{
                    recordIssues sourceCodeRetention: 'LAST_BUILD', tools: [pmdParser(pattern: '**/pmd.xml')]
                }
            }
        }
        stage('TestCode'){
            steps{
                sh 'mvn test'  
            }
            post{
                always{
                    echo 'Convert test reports'
                }
                success{
                    junit stdioRetention: '', testResults: 'target/surefire-reports/*.xml'
                }
            }
        }
    }
}