#!/bin/bash
exec 2> >(perl -pe '$x=`date "+%d %b %Y %H:%M %p"`;chomp($x);$_=$x." ".$_' >/var/log/mendeley/documentRetrieval.log)

LOGFILE=/var/log/mendeley/documentRetrieval.log
touch $LOGFILE
cat /dev/null > $LOGFILE

STARTTIME=$(date +%s)
node app.js > $LOGFILE 2>&1 & export PID=$!
sleep 5
casperjs authenticate.js >> $LOGFILE 2>&1
kill $PID

ENDTIME=$(date +%s)
echo "It takes $(($ENDTIME - $STARTTIME)) seconds to complete Mendeley document retrieval."
(>&2 echo "It takes $(($ENDTIME - $STARTTIME)) seconds to complete Mendeley document retrieval.")
