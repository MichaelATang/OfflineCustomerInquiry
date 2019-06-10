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
    cat output/queries.txt | cut -d"," -f2 | sort -k2 | uniq -c
   ;;
"2")
   
    cat output/queries.txt | cut -d"," -f2 | sort -k2 | uniq -c | grep "Disconnection"
   ;;
"3")
      # declare an associative array for sum storage	
      declare -A queryTypes	
      
      # read data from files
      while read -e line
      do
	# cut line down to required elements      
	# query type
	queryT=$(echo $line | cut -d"," -f2 | sort -k2 ) 	

	# query amount
	queryA=$(echo $line | cut -d"," -f4 | sort -k2 ) 	

	# check if there is a key named as the query type
	if [ $(echo "${!queryTypes[@]}" | grep -c -w "$queryT") -gt 0 ]
	then
           queryTypes["$queryT"]=$(echo "${queryTypes["$queryT"]}+$queryA" | bc )       
        else
          # assign amount to associative array		
	  queryTypes["$queryT"]=$queryA
        fi
      done < output/queries.txt


      # print out the array and values
      for key in ${!queryTypes[@]}
      do
	echo -n "$key $"
        echo "${queryTypes[$key]}"	
      done

   ;;	
"4")
     cat output/queries.txt   

   ;;

"5")
   #https://linuxhint.com/bash_script_send_email/

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
