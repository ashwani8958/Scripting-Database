source repeat_new_entry.sh
function insert()
{
clear
echo -n "enter the name :- "
read name
echo -n "enter the phone number :- "
read phone_no
echo -n "enter the email id :- "
read email_id
check_name=$(echo "$name" | grep [^a-z\ ] -ic)
vaild_number=$(echo "$phone_no" | grep [^0-9] -ic)
number_count=$(echo $phone_no | tr -d '\n' | wc -c)
vaild_email=$(echo $email_id | grep -E -o -c "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b")
	if [ $check_name -eq 0 -a $vaild_number -eq 0 -a $number_count -eq 10 -a $vaild_email -eq 1 ]
	then
		if [ ! -d ~/Database ]
		then
			mkdir ~/Database
			echo "$name;$phone_no;$email_id" >> ~/Database/database.csv
			echo "New entry is made on :- $(date)" >> ~/Database/database.log
		else
			echo "$name;$phone_no;$email_id" >> ~/Database/database.csv
			echo "New entry is made on :- $(date)" >> ~/Database/database.log
		fi
	else
		echo NOT A VAILD INPUTS
	fi
repeat_entry
}
