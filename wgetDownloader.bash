# requires a pre-made directories on Desktop/folder "imp" and inside which another directory/folder "many" exsists before he code is executed
# to download multiple url, paste the links in the .txt file and save it in the many folder.

read -r -p "Do you have multiple URL?[0-No/1-Yes]" answer
											# reading the answer from the user
if [[ "$answer" = 0 ]] ; then  								#checking the user input using if test1	
	read -r -p "Enter the site URL: " url						# storing the URL of the site in the variable
  read -r -p "Quick Download[0-NO/1-Yes]" answer2					
  if [[ "$answer2" = 1 ]] ; then		 					# reading the answer from the user     
	cd imp/ && wget -cr -t10  "$url" || exit 1					#quick download wget script code for Single URL	exit 1 exiting on failure 
  else 
	cd imp/ && wget -cm -t10 "$url" || exit 1					#quick download wget script code for Multiple URL exit 1 exiting on failure 	
	fi
   echo "The File has been Downloaded"
   tar -zvcf "$url".tgz "$url" || exit 1						#tarring and gziping the file fromed after zipping by the variable name url.tgz
   echo "Back up Tarred and saved"
   mv "$url".tgz backup 	 							#moving the file into another directory backup		   
else  
	read -r -p "Input the path of the file containing list of URLs." path		#reading the file where the .txt file is stored
	read -r -p "Quick Download[0-NO/1-Yes]" answer2
 	if [[ "$answer2" = 1 ]] ; then
	
    	cd imp/many && wget -cr -t10 -i "$path" || exit 1 && cd ..			# quick donwload using the path exit 1 exiting on failure 
  	else 
    	cd imp/many && wget -cm -t10 -i "$path" || exit 1 && cd .. 			# mirror donlwoad using the path exit 1 exiting on failure	
	fi    	
   echo "The File has been Downloaded"
   tar -zvcf many.tgz many || exit 1
   echo "Back up Tarred and saved"
   mv many.tgz backup 	 
  fi
