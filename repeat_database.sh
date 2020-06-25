function repeat_d()
{
while [ 1 ]
	do 
	echo -n "Do you want to print the pattern again y/n: "
	read n
	if [ $n = y ]
		then
		bash database.sh
	else
		exit
	fi
exit
	done
}
