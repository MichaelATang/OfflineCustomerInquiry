#!/bin/bash

clear

echo -e "\t\t\t\t\t##########  Select type of query ##########"
echo -e "\t\t\t[1] Payment"
echo -e "\t\t\t[2] Disconnection"
echo -e "\t\t\t[3] Billing"
echo -e "\t\t\t[4] New Service"
echo -e "\t\t\t[5] Change of Tenancy"
read -p "                            Enter your selection: " selection


function saveQuery(){

    clear
    
    queryDate=$(date)
    queryType=$1
    
    echo -n "Enter the details of the $1 query dated: $queryDate"
    read -p ": " queryDetails
    read -p "Enter payment adjustment value if any: " payment

    echo $accountNumber,$queryType,$queryDetails,$payment >> ./output/queries.txt
}

case $selection in
    1) saveQuery "Payment" ;;
    2) saveQuery "Disconnection" ;;
    3) saveQuery "Billing" ;;
    4) saveQuery "New Service" ;;
    5) saveQuery "Change of Tenancy" ;;
    *) echo "Please enter [1-5]: " 
esac


