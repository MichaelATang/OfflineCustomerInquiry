#!/bin/bash

# clear screen
clear

# default customer name is blank
customerName=""

# default menu selection = 0
menuSelection=0

function menuDisplay(){
      printf "\n\n\n\n\nQuery Another Name[3] Query Account[2] Main Menu[1] \e[31mExit[5] \e[0m \n"
      printf "\e[92mEnter Menu Selection: \e[0m"
      read -p "" menuSelection

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


function  printBiodata(){
     
   local accountNum=$(echo $@ | cut -d"," -f1)
   local name=$(echo $@ | cut -d"," -f2)
   local address=$(echo $@ | cut -d"," -f3)
   
   
   echo -n -e "Account Number: $accountNum  Customer Name:  $name  Address:  $address \n"  
   echo "-------------------------------------------------------------------------------------" 
}


while [ menuSelection != "5" ]
do
      
      clear
      read -p "Enter Customer Name: " customerName      
      clear

      printf "\e[92m##################################### Found Customers #################################\e[0m\n"   

      while read line
      do
         
         name=$(echo "$line" | cut -d"," -f2)         
         
         if [[ $name == *$customerName* ]]
         then
            printBiodata $line
         fi
         
      done < customerdata/biodata_dbtest.csv
      printf "\n"
      menuDisplay
done