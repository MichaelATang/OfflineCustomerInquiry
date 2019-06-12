#!/bin/bash


function summary(){
   cat output/queries.txt | cut -d"," -f2 | uniq -c
}

function queries_by_type(){
   cat output/queries.txt | cut -d"," -f2 | uniq -c | grep "Disconnection"
}

function money_by_query_type(){
    # declare an associative array for sum storage	
   declare -A queryTypes	
      
   # read data from files
   while read -e line
   do
	# cut line down to required elements      
	# query type
	queryT=$(echo $line | cut -d"," -f2 ) 	

	# query amount
	queryA=$(echo $line | cut -d"," -f4 ) 	

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
}

function query_detail(){
      cat output/queries.txt
}

function email_data(){
   #https://linuxhint.com/bash_script_send_email/
   #https://www.tecmint.com/send-mail-from-command-line-using-mutt-command/
   mutt -s "GPL Outreach" michaelandrewtang@gmail.com -a output/queries.txt < config/emailBody.txt 
}

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
     summary
   ;;
"2")
     queries_by_type    
   ;;
"3")
     money_by_query_type
   ;;	
"4")
     query_detail  
   ;;

"5")
   email_data
   ;;	

"6")
    source mainMenu.sh
   ;;
"7" )
   clear
   exit
   ;;
*)
   echo "Please enter 1-7: " ;;
esac
