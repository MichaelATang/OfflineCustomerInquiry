#!/bin/bash


# clear screen
clear

# default customer account is blank
customerAccount=""

# default menu selection = 0
menuSelection=0

function menuDisplay(){
      echo  -e "\n\n\n\n\n\t\t Query Another Account[3] Record Query Information[2] Main Menu[1] Exit[5]"
      read -p "Enter Menu Selection: " menuSelection

      case $menuSelection in 
         "5") 
            clear
            exit
         ;;
         "2")
            source searchByAccount.sh
         ;;
         "3")
            return
         ;;
         "1")
            source mainMenu.sh   
         ;;
      esac

}


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


while [ menuSelection != "5" ]
do
      clear
      
      read -p "Enter Account Number: " customerAccount  

      # case $customerAccount in 
      #    "5") 
      #       clear
      #       exit
      #    ;;
      #    "1")
      #       source mainMenu.sh   
      #    ;;
      # esac

      while read line
      do
         
         account=$(echo "$line" | cut -d"," -f1)
         
         if [[ $account == $customerAccount ]]
         then
            printBiodata $line
         fi
         
      done < customerdata/biodata.csv

      menuDisplay
done