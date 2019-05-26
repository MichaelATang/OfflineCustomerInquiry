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

    echo -n "Enter the details of the $1 query dated: $queryDate"
    read -p ": " queryDetails
    read -p "Enter payment adjustment value if any: " payment

    echo $accountNumber,$queryDetails,$payment > ./output/queries.txt
}

case $selection in
    1) saveQuery "Payment" ;;
    *) echo "Please enter [1-5]: " 
esac


