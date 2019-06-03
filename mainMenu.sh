clear
printf "\n\n\n\n\n**************** GPLs OFFLINE ACCOUNT INQUIRY********************\n"
echo "********** Welcome: $(whoami)       Date: $(date +%d-%m-%Y) ****************"
printf "*********************** MENU   **********************************\n"
printf "*********** 1) Generate Current Customer Files ******************\n"
printf "*********** 2) Search By Customer Account #  ********************\n"
printf "*********** 3) Search By Customer Name  *************************\n"
printf "*********** 4) Reports                  *************************\n"
printf "*********** 6) Email Data               *************************\n"
printf "*********** 5) Exit                     *************************\n"
printf "*****************************************************************\n\n"

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
                source searchByName.sh
                ;;
        "4")
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
