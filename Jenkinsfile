pipeline {
    agent any
    stages {
      /*  stage('---clean---') {
            steps {
                sh 'pwd'
              
                echo workspace
               sh 'xcodebuild clean -workspace EasyApp.xcworkspace -scheme EasyApp'
               
                sh 'pwd'
            }
        }
        stage('---build---') {
            steps {
                //sh 'xcodebuild archive -workspace EasyApp.xcworkspace -scheme "EasyApp" -configuration Release -archivePath "{$WORKSPACE}/build/iphone-Releasos/EasyApp.xcarchiv" -sdk iphoneos '
               // sh 'xcodebuild archive -workspace EasyApp.xcworkspace -scheme "EasyApp" -allowProcisioningUpdates ' 
                //sh 'xcodebuild -scheme "EasyApp" -workspace EasyApp.xcworkspace/ build -allowProvisioningUpdates'
                sh 'pwd'
                //sh 'xcodebuild -list -workspace EasyApp.xcworkspace'
            }
        }*/
        stage('---fastlane---'){
            steps{
           //   sh'fastlane init'
              sh 'fastlane gym --workspace "EasyApp.xcworkspace" --scheme "EasyApp" --clean'
            }
        }
    }
}
