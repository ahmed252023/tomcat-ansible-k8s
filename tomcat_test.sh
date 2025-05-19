#!/bin/bash
#
# Check that tomcat is running well
# Run this script after tomcat installation

export ENVIRONMENT=$1

usage() {
    echo "Usage:  $0 <ENVIRONMENT>"
    exit 1
}

if [ $# -ne 1 ]
then
    usage
fi

echo ""
echo "Deploy Tomcat using Ansible"
echo "---------------------------"
ansible-playbook --extra-vars="env=${ENVIRONMENT}" tomcat_deploy.yml
echo ""

echo "Check java process and parameters"
echo "---------------------------------"
ps -ef | grep java
echo ""

echo "Waiting 10 seconds to allow Tomcat to finish starting up..."
sleep 10
echo ""

echo "Check tomcat service status"
echo "---------------------------"
ps -ef | grep org.apache.catalina.startup.Bootstrap
echo ""

echo "Check application home page"
echo "---------------------------"
sleep 10
curl http://localhost:8080/sample/
echo ""

echo "Check tomcat logs"
echo "-----------------"
cat /opt/tomcat/logs/catalina.out

