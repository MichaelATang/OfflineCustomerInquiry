#!/bin/bash

echo "1) Summary"
echo "2) Queries By Type"
echo "3) Money Value by Query Type"
echo "4) Query Detail"
echo "5) Email Data"
read -p "Enter your selected: " selection

case $selection in
"1") 
   echo -e $(cat output/queries.txt | cut -d"," -f2 | sort -k2 | uniq -c) ;;
"2")
  # cat output/queries.txt  | cut -d"," -f2,4 | sort -k2
*)
   echo "Please enter 1-2: " ;;
esac
