#!/bin/bash


function email_data(){
   #https://linuxhint.com/bash_script_send_email/
   #https://www.tecmint.com/send-mail-from-command-line-using-mutt-command/
   mutt -s "GPL Outreach" $1 -a output/queries.txt < config/emailBody.txt 

   source mainMenu.sh
}


clear
printf "\n\n\n\n\n**************** \e[1m GPLs OFFLINE ACCOUNT INQUIRY \e[0m******************\n"
printf "********** \e[1m Welcome: \e[0m %s      \e[1m Date: \e[0m %s ************* \n" $(whoami) $(date +%d-%m-%Y)
printf "***********\t\t  \e[1m  \e[4m MAIN MENU  \e[0m    \t\t*********"

if [ $(id -u) -eq 0 ]
then
        printf "\n*********** 0) Install Prerequisite Software    *****************"
fi

printf "
*********** 1) Generate Current Customer Files  *****************
*********** 2) Search By Customer Account #     *****************
*********** 3) Search By Customer Name          *****************
*********** 4) Search By Address                *****************
*********** 5) Reports                          *****************
*********** 6) Email Data                       *****************
*********** \e[31m9) Exit\e[0m                             *****************
*****************************************************************\n\n
\t \e[92m Enter your selection: \e[0m  "
read -p  ""   menu_selection

case $menu_selection in
        "0")
                source installSoftware.sh
                ;;

        "1")
                clear
                # check for prerequisite software installation
                printf " Importing customer data....\n"
                source generateFiles.sh
                ;;
        "2")
                clear
                #read -p " Enter Your 7 Digit Customer Account # "  account_number                
                #${BASH_SOURCE[0]}
                source searchByAccount.sh
                ;;
        "3")
                # search by name
                source searchByName.sh
                ;;
        "4")
                # search by name
                source searchByAddress.sh
                ;;        
        "5")
                # reporting
                source reports.sh
                ;;
        "6")
               clear
               read -p "Please enter email address: " emailAddress
               email_data $emailAddress
                ;;                               
        "9")
                clear
                exit
                ;;
        *)
                printf " Please select either 1 - 5 \n"
                ;;
esac
