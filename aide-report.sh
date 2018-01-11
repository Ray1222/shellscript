#!/bin/sh
#keli Aide report by ljr1222
DATE=`date +%Y-%m-%d`
REPORT="Aide-Report-ktli.apps.XXX.edu.tw-"$DATE
echo "Aide-Report-ktli.apps.XXX.edu.tw `date`" > /tmp/$REPORT
/usr/sbin/aide -c aide-ktli.conf >> /tmp/$REPORT
echo "****************DONE******************" >> /tmp/$REPORT

#ADD=$(cat /tmp/$REPORT|grep Added|awk -F " " '{print $1":"$3}')
#REMV=$(cat /tmp/$REPORT|grep Removed|awk -F " " '{print $1":"$3}')
#CHG=$(cat /tmp/$REPORT|grep Changed|awk -F " " '{print $1":"$3}')

STATE=`cat /tmp/$REPORT|grep -e okay |awk '{print $8}'`
#ALL="$ADD ;$REMV ;$CHG"

if [ $STATE = "okay!" ]
then

ALL=OK!

else

ALL=`cat /tmp/$REPORT|sed -n '/Total/,/Changed files/p'|sed ':a;N;$!ba;s/\n/ /g'`
fi
echo $ALL
cat << _EOT_ | \
        /usr/sbin/smtp-cli --server=XXX.edu.tw \
                   --from=sysinfo@XXX.edu.tw \
                   --to=ljr1234@XX.edu.tw \
                   --subject="$REPORT $ALL" \
                   --body-plain=/tmp/$REPORT

_EOT_


