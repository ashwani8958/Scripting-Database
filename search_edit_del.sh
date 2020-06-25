function search_edit_del()
{
clear
echo -n "Enter the name you want to edit/delete in database :- "
read search
count=$(cut -d";" -f1 ~/Database/database.csv | grep -ic $search)
        if [ $count -eq 0 ]
        then
		clear
                echo
                echo "Searched entry is not present in Database"
                echo 

#<?????????????????????????????????????????????????????     SINGLE RECORD FOUND     ???????????????????????????????????????????????????>
        elif [ $count -eq 1 ]
        then
		clear
		line_number=$(cut -d";" -f1 ~/Database/database.csv | grep -ni $search | cut -d":" -f1)
		echo
		grep -ni $search ~/Database/database.csv
		echo
		echo "1 :- EDIT"
		echo "2 :- DELETE"
		echo -n "Press 1 for edit and 2 delete :- "
		read choice
			case $choice in
#<---------------------------------------------------------------EDIT------------------------------------------------------------------>
			1)
			clear
			echo "EDIT OPTIONS ARE"
			echo "1 :- EDIT NAME"
			echo "2 :- EDIT PHONE NUMBER"
			echo "3 :- EDIT EMAIL"
			echo "4 :- SAVE AND EXIT"
			echo -n "CHOOSE THE ACTION :- "
			read edit_choice
			case $edit_choice in 
#<----------------------------------------------------------EDIT NAME------------------------------------------------------------------>
				1)
				clear
				grep -ni $search ~/Database/database.csv
				echo -n "Enter the Correct Name :- "
				read new_name
				check_name=$(echo "$new_name" | grep [^a-z\ ] -ic)
				if [ $check_name -eq 0 ]
				then
					name=$(cut -d";" -f1 ~/Database/database.csv | grep $search)
					sed -i "${line_number}s/$name/$new_name/" ~/Database/database.csv 
					echo "In line no. $line_number $name is change to $new_name :- $(date)" >> ~/Database/database.log
				else
					clear
					echo "ENTER CORRECT NAME"
					echo "RECORDS ARE NOT CHANGE"
					echo "Unsuccessful attempt is made to change $name In line no. $line_number :- $(date)" >> ~/Database/database.log
				fi
				;;
#<------------------------------------------------------EDIT PHONE NUMBER----------------------------------------------------------->
				2)
				clear
				grep -ni $search ~/Database/database.csv
				echo -n "Enter the correct phone number :- "
				read new_number
				check_number=$(echo "$new_number" | grep [^0-9] -ic)
				number_count=$(echo "$new_number" | tr -d '\n' | wc -c)
				if [ $check_number -eq 0 -a $number_count -eq 10 ]
				then
					num=$(cut -d";" -f2 ~/Database/database.csv | sed -n "${line_number}p")
					sed -i "${line_number}s/$num/$new_number/" ~/Database/database.csv
					echo "In line no. $line_number $num is change to $new_number :- $(date)" >> ~/Database/database.log
				else
					echo "ENTER THE CORRECT NUMBER"
					echo "RECORDS ARE NOT CHANGE"
					echo "Unsuccessful attempt is made to change $num In line no. $line_number :- $(date)" >> ~/Database/database.log
				fi
				;;
#<-----------------------------------------------------   EDIT EMAIL ID   --------------------------------------------------------->
				3) clear
				grep -ni $search ~/Database/database.csv
				echo -n "Enter the correct email id :- "
				read new_email
				check_email=$(echo "$new_email" | grep -E -o -c "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b")
				if [ $check_email -eq 1 ]
				then
					old_email=$(cut -d";" -f3 ~/Database/database.csv | sed -n "${line_number}p")
					sed -i "${line_number}s/$old_email/$new_email/" ~/Database/database.csv
					echo "In line no. $line_number $old_email is change to $new_email :- $(date)" >> ~/Database/database.log
				else
					echo "ENTER THE EMAIL ID"
					echo "RECORDS ARE NOT CHANGE"
					echo "Unsuccessful attempt is made to change $old_email In line no. $line_number :- $(date)" >> ~/Database/database.log
				fi
				;;
#<-------------------------------------------------------   SAVE AND EXIT   --------------------------------------------------------->
				4)
				echo "Save and edit from records :- $(date)" >> ~/Database/database.log
				exit
				;;
#<-------------------------------------------------------    DEFAULT     ------------------------------------------------------------>
				*)
				clear
				echo "Unsuccessful attempt to edit the records, records are not changed :- $(date)" >> ~/Datebase/database.log
                                echo "RECORDS ARE NOT CHANGE"
				;;
				esac
			;;
#<------------------------------------------------------------DELETE----------------------------------------------------------------->
			2) 
				del_single=$(sed -n "${line_number}"p ~/Database/database.csv)
				sed -i "${line_number}d" ~/Database/database.csv
				echo "Line number $line_number $del_single had been delete :- $(date)" >> ~/Database/database.log
				echo "Delete line was $del_single"
			;;
			*)
			  clear
			  echo not a vaid choice
			  echo "Unsuccessful attempt to delete the records, records are not change :- $(date)" >> ~/Database/database.log
			;;
			esac
#
#
#
#
#
#<?????????????????????????????????????????????????       MULTIPLY RECORDS FOUND      ???????????????????????????????????????????????????????>
        else
		clear
		echo
		echo "Multiple entries with same name are found in database"
		echo "Choose from giventwo option"
		echo "1 :- EDIT"
		echo "2 :- DELETE"
		echo -n "Press 1 for edit and 2 delete :- "
		read choice
			case $choice in
#<------------------------------------------------------------EDIT-------------------------------------------------------------------->
			1)
			clear
			grep -ni $search ~/Database/database.csv
			echo -n "Enter the line number which you want to edit :- "
			read edit_line_number
			clear
			sed -n "${edit_line_number}"p ~/Database/database.csv
			echo "EDIT OPTIONS ARE"
			echo "1 :- EDIT NAME"
			echo "2 :- EDIT PHONE NUMBER"
			echo "3 :- EDIT EMAIL"
			echo "4 :- SAVE AND EXIT"
			echo -n "CHOOSE THE ACTION :- "
			read edit_choice
			case $edit_choice in 
#<----------------------------------------------------------EDIT NAME------------------------------------------------------------------>
				1)
				clear
				grep -ni $search ~/Database/database.csv
				echo -n "Enter the Correct Name :- "
				read new_name
				check_name=$(echo "$new_name" | grep [^a-z\ ] -ic)
				if [ $check_name -eq 0 ]
				then
					name=$(sed -n "${edit_line_number}"p ~/Database/database.csv | cut -d";" -f1 )
					sed -i "${edit_line_number}s/$name/$new_name/" ~/Database/database.csv
					echo "In line no. $edit_line_number $name is change to $new_name :- $(date)" >> ~/Database/database.log
				else
					clear
					echo "ENTER CORRECT NAME"
					echo "RECORDS ARE NOT CHANGE"
					echo "Unsuccessful attempt is made to change $name In line no. $edit_line_number :- $(date)" >> ~/Database/database.log
				fi
				;;
#<------------------------------------------------------EDIT PHONE NUMBER----------------------------------------------------------->
				2)
				clear
				grep -ni $search ~/Database/database.csv
                                echo -n "Enter the correct phone number :- "
                                read new_number
                                check_number=$(echo "$new_number" | grep [^0-9] -ic)
                                number_count=$(echo "$new_number" | tr -d '\n' | wc -c)
                                if [ $check_number -eq 0 -a $number_count -eq 10 ]
                                then
                                        num=$(sed -n "${edit_line_number}"p ~/Database/database.csv | cut -d";" -f2)
                                        sed -i "${edit_line_number}s/$num/$new_number/" ~/Database/database.csv
					echo "In line no. $edit_line_number $num is change to $new_number :- $(date)" >> ~/Database/database.log
                                else
					clear
                                        echo "ENTER THE CORRECT NUMBER"
                                        echo "RECORDS ARE NOT CHANGE"
					echo "Unsuccessful attempt is made to change $num In line no. $edit_line_number :- $(date)" >> ~/Database/database.log
                                fi
	
				;;
#<-----------------------------------------------------   EDIT EMAIL ID   --------------------------------------------------------->
				3)
				grep -ni $search ~/Database/database.csv
				clear
                                echo -n "Enter the correct email id :- "
                                read new_email
                                check_email=$(echo "$new_email" | grep -E -o -c "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b")
                                if [ $check_email -eq 1 ]
                                then
                                        old_email=$(sed -n "${edit_line_number}"p ~/Database/database.csv | cut -d";" -f3)
					echo $old_email	
                                        sed -i "${edit_line_number}s/$old_email/$new_email/" ~/Database/database.csv
					echo "In line no. $edit_line_number $old_email is change to $new_email :- $(date)" >> ~/Database/database.log
                                else
					clear
					echo "ENTER THE EMAIL ID"
                                        echo "RECORDS ARE NOT CHANGE"
					echo "Unsuccessful attempt is made to change $old_email In line no. $edit_line_number :- $(date)" >> ~/Database/database.log
				fi
				;;
#-------------------------------------------------------   SAVE AND EXIT   --------------------------------------------------------->
				4)
				exit
				;;
#<---------------------------------------------------         DEFAULT    ----------------------------------------------------------->
				*)
				clear
				echo "Unsuccessful attempt to edit the records, records are not change :- $(date)" >> ~/Database/database.log
				echo "RECORDS ARE NOT CHANGE"
				;;
				esac


;;
#<-----------------------------------------------------------DELETE------------------------------------------------------------------->
			2)
				clear
				grep -ni $search ~/Database/database.csv
				echo
				echo -n "Enter the line number you want to delete :- "
				read del_line
				del=$(sed -n "${del_line}"p ~/Database/database.csv)
				sed -i "${del_line}d" ~/Database/database.csv
				echo "Line number $del_line:$del had been deleted :- $(date)" >> ~/Database/database.log
				echo "Deleted line was $del"
			;;
			*)echo not a vaid choice
			  echo "Unsuccessful attempt to delete the records, records are not change :- $(date)" >> ~/Database/database.log
			;;
			esac

        echo
        fi
}
