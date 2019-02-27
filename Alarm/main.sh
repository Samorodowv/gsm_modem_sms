#!/bin/bash

send ()
{
  NUMBER=$1
  MESSAGE="$2"
  echo sending to the number $NUMBER message "${MESSAGE}"
#/home/pi/alarm/./sendmessage.sh $NUMBER "${MESSAGE}"
}

setup ()
{ echo запуск обработчика нажатий
  sleep 5
  
  gpio mode 29 out ;
  gpio write 29 0 ;

  gpio mode 25 in ; #
  gpio mode 25 up ;

  sleep 5 
  gpio write 29 1 ;

  result=`gpio read 25`
  if [ $result -eq 0 ]; then
	send +79996667777 "Error of gpio init (25)"
	exit
  fi

  echo init completed
}

#############################################################
setup

while :
do
#Отправка в цикле, можно на несколько кнопок
	result=`gpio read 25`
	if [ $result -eq 0 ]; then
		gpio write 29 0 ;
		echo "Alarm message!"  
		while read p; do
		  send "${p}" "Alarm! Something happened!"
		done </home/pi/alarm/numbers
		echo pause
		sleep 60
		gpio write 29 1 ;
		echo continue
        fi
sleep 0.1

done 
