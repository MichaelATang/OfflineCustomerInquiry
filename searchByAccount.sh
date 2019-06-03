#!/bin/bash

function printFinancialData(){

    echo "############################ Financial Data ############################"
    printf "%-20s %-20s \n" "Date" "Transaction Amount"

    while read line
    do
       
      local accountNum=$(echo "$line" | cut -d"," -f1)
      local transactionDate=$(echo "$line" | cut -d"," -f2)
      local transactionAmount=$(echo "$line " | cut -d"," -f3)
    
      if [ $accountNum == $1 ]
      then
               
               printf "%-20s $%-20s \n" $transactionDate $transactionAmount
      fi
      
      done < customerdata/financialdata.csv

     echo  -e "\n\n\n\n\n\t\t\tRecord Query Information[2] Main Menu[1] Exit[0]: "
      
}

function  printBiodata(){
  
   clear

   echo "################################ Customer ##############################"

   accountNum=$(echo $@ | cut -d"," -f1)
   name=$(echo $@ | cut -d"," -f2)
   address=$(echo $@ | cut -d"," -f3)
   
   
   echo "Account Number: $accountNum "
   echo "Customer Name:  $name "
   echo "Address:  $address "

   printFinancialData $accountNum

   
}

clear
customerName=""

while [ customerName != "E" ]
do

      read -p "Enter Account Number: " customerName

      echo $customerName

      case $customerName in 
         "0") 
            clear
            exit
         ;;
         "1")
            source mainMenu.sh   
         ;;
      esac

      while read line
      do
         
         name=$(echo "$line" | cut -d"," -f2)
         
         if [[ $name == *$customerName* ]]
         then
            printBiodata $line
         fi
         
      done < customerdata/biodata.csv
done