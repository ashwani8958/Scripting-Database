#!/bin/bash
source insert.sh
source display_record.sh
source search_edit_del.sh
while [ 1 ]
do
echo "1 :- Insert new record "
echo "2 :- Search records"
echo "3 :- Edit/Delete record"
echo "4 :- Exit"
echo -n "Enter your choice :- "
read choice
case $choice in
1)
insert;;
2)
display;;
3)
search_edit_del;;
4)
clear
exit;;
*)
echo out;;
esac
done
