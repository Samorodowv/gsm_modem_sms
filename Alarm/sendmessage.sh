#!/bin/bash

NUMBER=$1
MESSAGE=$2


./session.sh
./token.sh

LENGTH=${#MESSAGE}
TIME=$(date +"%Y-%m-%d %T")
TOKEN=$(<token.txt)

SMS="<request><Index>-1</Index><Phones><Phone>$NUMBER</Phone></Phones><Sca/><Content>$MESSAGE</Content><Length>$LENGTH</Length><Reserved>1</Reserved><Date>$TIME</Date></request>"

echo $SMS

curl  -b session.txt -c session.txt -H "X-Requested-With: XMLHttpRequest" --data "$SMS" http://192.168.8.1/api/sms/send-sms --header "__RequestVerificationToken: $TOKEN" --header "Content-Type:text/xml"
sleep 0.5

