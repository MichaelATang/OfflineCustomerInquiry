
#!/bin/bash

which docker

if [ $? -ne 0 ]
then
    echo "######### Installing Docker ############"
    echo "########## Updating Repositories #############"
    sudo apt -qq update
    
    echo "########## Installing Prerequisites ##########"
    sudo apt -qq -y install apt-transport-https ca-certificates curl software-properties-common
    
    echo "########## Adding Docker's GPG Key ###########"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
    
    echo "########## Installing Docker Repository #########"
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

    echo "########## Updating Repositories #############"
    sudo apt -qq update

    echo "####### Install Latest Version of Docker #######"
    sudo apt -y -qq  install docker-ce
    sudo snap install docker
    sudo docker start
fi


    echo "####### Docker Installed #########"

    echo "#### Get Dockerfile from GIT Repo ########"
    wget https://raw.githubusercontent.com/oracle/docker-images/master/OracleInstantClient/dockerfiles/19/Dockerfile

    echo "##### Building Docker Image ########"
    # maybe add a wait time
    
    sudo docker build -t oracle/instantclient:19 .
