# This script will install all the plugins which are mentioned in the plain.txt file and after installation it will restart the jenkins in a safe mode.

#!/bin/bash
set -x
for plugin in $(cat plugins.txt); do \
    java -jar /home/varun/Jekins-cli/jenkins-cli.jar \
    -s http://localhost:8080/ \
    -auth $JENKINS_USER:$JENKINS_PASSWORD \
    install-plugin $plugin; \
done
java -jar /home/varun/Jekins-cli/jenkins-cli.jar -s http://laptop-vanv0g5o/:8080/ -auth $JENKINS_USER:$JENKINS_PASSWORD safe-restart