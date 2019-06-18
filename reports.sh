#!/bin/bash

# default menu selection = 0
menuSelection=0

function summary(){
   cat output/queries.txt | cut -d"," -f2 | sort | uniq -c
   
   # pause effect
   read -p ""
}

function queries_by_type(){
   cat output/queries.txt | cut -d"," -f2 | uniq -c | grep "Disconnection"
   
   # pause effect
   read -p ""
}

function money_by_query_type(){
    # declare an associative array for sum storage	
   declare -A queryTypes	
      
   #set -x
   
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

    #set +x

   # pause effect
   read -p ""
}

function query_detail(){
      #cat output/queries.txt

      while read -e line
      do
      
      account=$(echo $line | cut -d"," -f1 )

      # query type
      queryT=$(echo $line | cut -d"," -f2 ) 

      # query comments
      queryC=$(echo $line | cut -d"," -f3 )	

      # query amount
      queryA=$(echo $line | cut -d"," -f4 ) 	


      printf "Account: %-20s Query Type: %-20s \nComments: %s"  $account $queryT 
      echo -n $queryC
      printf " \nEstimated Amount: %s \n-----------------------------------------------------------------\n" $queryA
      done < output/queries.txt


      # pause effect
      read -p ""
}

function email_data(){
   #https://linuxhint.com/bash_script_send_email/
   #https://www.tecmint.com/send-mail-from-command-line-using-mutt-command/
   mutt -s "GPL Outreach" michaelandrewtang@gmail.com -a output/queries.txt < config/emailBody.txt 
}

clear


function menuDisplay(){
      clear

printf "\n\n\n\n\n**************** \e[1m GPLs OFFLINE ACCOUNT INQUIRY \e[0m******************\n"
echo "********** Welcome: $(whoami)       Date: $(date +%d-%m-%Y) ****************"
printf "*********************** MENU   **********************************
**************** 1) Summary                     *****************
**************** 2) Queries By Type             *****************
**************** 3) Money Value by Query Type   *****************
**************** 4) Query Detail                *****************
**************** 5) Email Data                  *****************
**************** 6) Main Menu                   *****************
*****************************************************************\n\n"

      read -p "Enter your selection: " menuSelection

      case $menuSelection in
         "1") 
            clear
            summary
            ;;
         "2")
            clear
            queries_by_type    
            ;;
         "3")
            clear
            money_by_query_type
            ;;	
         "4")
            clear
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
            echo "Please enter 1-6: " 
         ;;
      esac

}

while [ menuSelection != "6" ]
do
     menuDisplay

done