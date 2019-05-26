clear
printf "\n\n\n\n\n*********** WELCOME TO GPLs OFFLINE ACCOUNT INQUIRY**************\n"
printf "*********************** MENU   **********************************\n"
printf "*********** 1) Import  Current Customer Data ********************\n"
printf "*********** 2) Search By Customer Account #  ********************\n"
printf "*********** 3) Search By Customer Name  *************************\n"
printf "*********** 4) List Saved Queries  *************************\n"
printf "*********** 5) Exit  *************************\n"

printf "*****************************************************************\n\n"

read -p  "        Enter your selection:        "   menu_selection

case $menu_selection in

        "1")
                clear
                printf " Importing customer data....\n"
                ;;
        "2")
                clear
                read -p " Enter Your 7 Digit Customer Account # "  account_number
                ;;
        q|Q)
                exit
                ;;
        *)
                printf " Please select either 1,2,3 or Q to quit \n"
                ;;
esac
