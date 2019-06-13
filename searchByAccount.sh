#!/bin/bash


# clear screen
clear

# default customer account is blank
customerAccount=""

# default menu selection = 0
menuSelection=0

# variable/flag to print account not found message if set
notFound=0

function menuDisplay(){
      echo  -e "\n\n\n\n\n----------------------------------------------------------------------------" 
      
      if [ $notFound -eq 0 ]
      then 
         echo  -e "Query Another Account[3] Save Query Information[2] Main Menu[1] Exit[5]"
      else
          echo  -e "Query Another Account[3] Main Menu[1] Exit[5]"
      fi

      read  -p "Enter Menu Selection: " menuSelection

      case $menuSelection in 
         "5") 
            clear
            exit
         ;;
         "2")
            #source searchByAccount.sh
            source saveQuery.sh $customerAccount
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
    
      if [ $accountNum = $1 ]
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

function printNotFoundMessage(){

   echo -e "\n\n\n\t\t\t\tAccount not found!"

}



while [ menuSelection != "5" ]
do
      clear
      
      read -p "Enter Account Number: " customerAccount  

      
      while read line
      do
         
         account=$(echo "$line" | cut -d"," -f1)
         
         if [[ $account = $customerAccount ]]
         then
            notFound=0
            printBiodata $line
            break
         else
            notFound=1         
         fi
         
      done < customerdata/biodata.csv

      if [ $notFound -eq 1 ]
      then
         printNotFoundMessage
      fi

      menuDisplay
done