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
         printf "Query Another Account[3] Save Query Information[2] Main Menu[1] \e[31m Exit[5] \e[0m \n"
      else
         printf "Query Another Account[3] Main Menu[1] \e[31mExit[5] \e[0m \n"
      fi
      
      printf "\e[92mEnter Menu Selection: \e[0m"
      read  -p "" menuSelection

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

function printConsumptionData(){

    echo -e "\n############################ Consumption Data ##########################"
    printf "\e[92m%-20s %-20s %-20s\e[0m\n" "Date" "Reading" "Consumption"

    while read line
    do
       
      local accountNum=$(echo "$line" | cut -d"," -f1)
      local readingDate=$(echo "$line" | cut -d"," -f2)
      local reading=$(echo "$line " | cut -d"," -f3)
      local consumption=$(echo "$line " | cut -d"," -f4)

      if [ $accountNum = $1 ]
      then               
         printf "%-20s %-20s %-20s\n" $readingDate $reading $consumption
      fi
      
      done < customerdata/consumptiondata_dbtest.csv
      
}


function printFinancialData(){

    echo -e "\n############################ Financial Data ############################"
    printf "\e[92m%-20s %-20s\e[0m \n" "Date" "Transaction Amount"

    while read line
    do
       
      local accountNum=$(echo "$line" | cut -d"," -f1)
      local transactionDate=$(echo "$line" | cut -d"," -f2)
      local transactionAmount=$(echo "$line " | cut -d"," -f3)
    
      if [ $accountNum = $1 ]
      then               
         printf "%-20s $%-20s \n" $transactionDate $transactionAmount
      fi
      
      done < customerdata/financialdata_dbtest.csv

      printConsumptionData $accountNum
      
}

function  printBiodata(){
  
   clear

   echo "################################ Customer ##############################"

   accountNum=$(echo $@ | cut -d"," -f1)
   name=$(echo $@ | cut -d"," -f2)
   address=$(echo $@ | cut -d"," -f3)
   
   
   echo -e "\e[92mAccount Number:\e[0m $accountNum "
   echo -e "\e[92mCustomer Name:\e[0m  $name "
   echo -e "\e[92mAddress:\e[0m  $address "

   printFinancialData $accountNum

   
}

function printNotFoundMessage(){
  
   printf "\e[31m\n\n\n\t\t\t\tAccount not found! \e[0m"   

}



while [ menuSelection != "5" ]
do
      clear
      
      printf "\e[92m Enter Account Number: \e[0m"
      read -p "" customerAccount  

      
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
         
      done < customerdata/biodata_dbtest.csv

      if [ $notFound -eq 1 ]
      then
         printNotFoundMessage
      fi

      menuDisplay
done