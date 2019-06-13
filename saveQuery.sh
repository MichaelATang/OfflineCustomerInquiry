#!/bin/bash

function menuDisplay(){
    echo -e "\t\t\t\t\t##########  Select type of query ##########"
    echo -e "\t\t\t[1] Payment"
    echo -e "\t\t\t[2] Disconnection"
    echo -e "\t\t\t[3] Billing"
    echo -e "\t\t\t[4] New Service"
    echo -e "\t\t\t[5] Change of Tenancy"
    echo -e "\t\t\t[6] Main Menu"

    read -p "                            Enter your selection: " selection

    case $selection in
        1) saveQuery "Payment" $1;;
        2) saveQuery "Disconnection" $1;;
        3) saveQuery "Billing" $1;;
        4) saveQuery "NewService" $1;;
        5) saveQuery "ChangeOfTenancy" $1;;
        6) source mainMenu.sh ;;
        *) echo "Please enter [1-5]: " 
    esac
}


function saveQuery(){

    clear
    
    queryDate=$(date)
    queryType=$1
    accountNumber=$2
    
    echo -e "Enter the details of the \e[1m $1 \e[0m query dated: $queryDate :"
    echo -e "\n"
    read -p "" queryDetails
    echo -e "\n\n"
    read -p "Enter payment adjustment value if any: " payment

    echo $accountNumber,$queryType,$queryDetails,$payment >> ./output/queries.txt

    clear

    echo "Query Successfully Saved!!!"

    read -p ""

    source mainMenu.sh
}

clear
menuDisplay $1



