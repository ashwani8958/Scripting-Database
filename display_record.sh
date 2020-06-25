function display()
{
clear
echo -n "enter the name you want to search in database :- "
read search
count=$(cut -d";" -f1 ~/Database/database.csv | grep -c $search)
	if [ $count -eq 0 ]
	then
		clear
		echo
		echo "Searched entry is not present in Database"
		echo
		echo "Records are search for name '$search', but not found in database :- $(date)" >> ~/Database/database.log  
	elif [ $count -eq 1 ]
	then
		clear
		echo
		grep -n $search ~/Database/database.csv
		echo
		echo "Records are search for name '$search' :- $(date)" >> ~/Database/database.log  
	else
		clear
		echo
		echo "Multiple entry are found in database"
		echo
		grep -n $search ~/Database/database.csv
		echo
		echo "Records are search for name '$search' :- $(date)" >> ~/Database/database.log  
	fi
}
