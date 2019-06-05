#!/bin/bash

# clear screen
clear

# default customer name is blank
customerName=""

# default menu selection = 0
menuSelection=0

function menuDisplay(){
      echo  -e "\n\n\n\n\n\t Query Another Name[3] Query Account[2] Main Menu[1] Exit[5]"
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

      echo "##################################### Found Customers #################################"   

      while read line
      do
         
         name=$(echo "$line" | cut -d"," -f2)         
         
         if [[ $name == *$customerName* ]]
         then
            printBiodata $line
         fi
         
      done < customerdata/biodata.csv
      printf "\n"
      menuDisplay
done