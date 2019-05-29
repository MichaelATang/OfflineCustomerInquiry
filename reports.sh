#!/bin/bash

clear

echo "1) Summary"
echo "2) Queries By Type"
echo "3) Money Value by Query Type"
echo "4) Query Detail"
echo "5) Email Data"
echo "6) Main Menu"
echo "7) Exit"

read -p "Enter your selected: " selection

case $selection in
"1") 
   echo -e $(cat output/queries.txt | cut -d"," -f2 | sort -k2 | uniq -c) 
   ;;
"2")
  # cat output/queries.txt  | cut -d"," -f2,4 | sort -k2
   ;;
"6")
    source mainMenu.sh
   ;;
"7" )
   clear
   exit
   ;;
*)
   echo "Please enter 1-2: " ;;
esac
