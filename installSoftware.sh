
#!/bin/bash

which docker

if [ $? -ne 0 ]
then
    echo "######### Installing Docker ############"
    echo "########## Updating Repositories #############"
    sudo apt -qqy update && sudo apt -qqy upgrade
    
    echo "####### Install Prerequisite Software #######" 
    sudo apt -y -qq  install docker docker-compose ssmtp gnupg2 pass


    #sudo snap install docker
    sudo docker start
fi

    echo "##### Configure SSMTP ####"
    
    echo "UseSTARTTLS=YES
    FromLineOverride=YES
    root=admin@example.com
    mailhub=smtp.gmail.com:587
    AuthUser=michaelandrewtang@gmail.com
    AuthPass=mypassword" | sudo tee -a /etc/ssmtp/ssmtp.conf


    echo "###### Build Oracle Test Database #####"
    sudo docker login    
    sudo docker pull store/oracle/database-enterprise:12.2.0.1
    sudo docker run -d -ti --name oracletestdb -p 1521:1521 -p 5500:5500 store/oracle/database-enterprise:12.2.0.1

    # wait for a few minutes for database to begin
    # connecting from outside to database
    # sudo docker exec -it oracletestdb bash -c "source /home/oracle/.bashrc; /bin/bash"
    
    # listening port
    # sudo docker port oracletestdb
    
    # instant client connection
    # sudo docker run -ti oracle/instantclient:19 sqlplus sys/Oradoc_db1@172.17.0.1:32771/ORCLPDB1.localdomain as sysdba
    # sudo docker run -ti oracle/instantclient:19 sqlplus testuser/testuser@172.17.0.1:32771/ORCLPDB1.localdomain

     
    echo "####### Docker Installed #########"

    echo "#### Get Dockerfile from GIT Repo ########"

    if [ -e Dockerfile ] 
    then
        echo "#### Dockerfile Exists!"
    else
        wget https://raw.githubusercontent.com/oracle/docker-images/master/OracleInstantClient/dockerfiles/19/Dockerfile
    fi

    echo "##### Building Docker Oracle Client Image ########"
    # maybe add a wait time
    
    sudo docker build -t oracle/instantclient:19 .


