function repeat_entry()
{
while [ 1 ]
        do
        echo -n "Do you want to create one more entry y/n: "
        read n
        if [ $n = y ]
                then
                bash insert.sh
        else
                exit
        fi
exit
        done
}

