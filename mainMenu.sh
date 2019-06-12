clear
printf "\n\n\n\n\n**************** \e[1m GPLs OFFLINE ACCOUNT INQUIRY \e[0m******************\n"
echo "********** Welcome: $(whoami)       Date: $(date +%d-%m-%Y) ****************"
printf "*********************** MENU   **********************************\n
*********** 1) Generate Current Customer Files ******************
*********** 2) Search By Customer Account #  ********************
*********** 3) Search By Customer Name  *************************
*********** 4) Reports                  *************************
*********** 6) Email Data               *************************
*********** 5) Exit                     *************************
*****************************************************************\n\n"

read -p  "        Enter your selection:        "   menu_selection

case $menu_selection in

        "1")
                clear
                # check for docker installation
                source installDocker.sh
                
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
                # reporting
                source reports.sh
                ;;                
        "5")
                clear
                exit
                ;;
        *)
                printf " Please select either 1 - 5 \n"
                ;;
esac
