#!/bin/bash

# default menu selection = 0
menuSelection=0

function summary(){

printf "\n\n\n\n\n################ Summary of Query Types ##################\n\n
\e[92mCount | Query Type\e[0m
\e[94m=================================\e[0m\n"
   cat output/queries.txt | cut -d"," -f2 | sort | uniq -c
   
   # pause effect
   read -p ""
}

# function queries_by_type(){
#    cat output/queries.txt | cut -d"," -f2 | uniq -c | grep "Disconnection"
   
#    # pause effect
#    read -p ""
# }

function money_by_query_type(){
    # declare an associative array for sum storage	
   declare -A queryTypes	
      
   #set -x

printf "\n\n\n\n\n################ Summary of Query Value ##################\n\n
\e[92mQuery Type | Amount\e[0m
\e[94m=================================\e[0m\n"
   
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
	     echo -n "$key    $"
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


      printf "\e[92mAccount:\e[0m %-20s \e[92mQuery Type:\e[0m %-20s \n\e[92mComments:\e[0m %s"  $account $queryT 
      echo -n $queryC
      printf " \n\e[92mEstimated Amount:\e[0m $%s \n\e[94m-----------------------------------------------------------------\e[0m\n" $queryA
      done < output/queries.txt



      # pause effect
      read -p ""
}


clear


function menuDisplay(){
      clear

printf "\n\n\n\n\n**************** \e[1m GPLs OFFLINE ACCOUNT INQUIRY \e[0m******************\n"
echo "********** Welcome: $(whoami)       Date: $(date +%d-%m-%Y) ****************"
printf "*********************** MENU   **********************************
**************** 1) Summary                     *****************
**************** 2) Money Value by Query Type   *****************
**************** 3) Query Detail                *****************
**************** 5) Main Menu                   *****************
*****************************************************************\n\n"

      read -p "Enter your selection: " menuSelection

      case $menuSelection in
         "1") 
            clear
            summary
            ;;
         # "2")
         #    clear
         #    queries_by_type    
         #    ;;
         "2")
            clear
            money_by_query_type
            ;;	
         "3")
            clear
            query_detail  
            ;;

         "5")
            source mainMenu.sh
            ;;
         "6" )
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