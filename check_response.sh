#!/bin/bash
HTTP="http://"
TIMEOUT=2
CURLOPT=""
POSTDATA=""
while getopts f:p:sa:m:t:hd:c: option
do
 case "${option}"
 in
 f) FILE=${OPTARG};;
 p) PORT=${OPTARG};;
 s) HTTP="https://";;
 a) SUFFIX=$OPTARG;;
 m) MATCH=$OPTARG;;
 t) TIMEOUT=$OPTARG;;
 d) POSTDATA=$OPTARG;;
 c) CURLOPT=$OPTARG;;
 h) HELP=true;;
 esac
done

if [ "$HELP" = true ] ; then
    echo '-f Input file (Required)'
    echo '-m Expected string in response (Required)'
    echo '-a Suffix to append'
    echo '-t Timeout in seconds'
    echo '-p Port number'
    echo '-h This help'
    echo '-s Enable https switch. Default http'
    echo '-d POST Data'
    echo 'Example usage: ./request_check.sh -f list.txt -m "logged-in" -a "/login.aspx" -p 8080 -d "u=username&p=pass123"'
    exit 1
fi

if [ -z "$FILE" ]
then
      echo "-f : Input file missing. Input file must end with an empty"
      exit 1
else
	if [ -z "$MATCH" ]
	then
	      echo "-m : Matched string required"
	      exit 1
	else
		:
	fi
fi

if [ -z "$PORT" ]
then
	:
else
	PORT=":${PORT}"
fi

if [ $POSTDATA = "" ]; then
   :
else
  POSTDATA="--data ${POSTDATA}"
fi

for i in $(cat $FILE)
do
	#sed -i 's/\r//
	i=$(echo "$i" | tr -d '\r')
	URL="$HTTP$i$PORT$SUFFIX"
	curl $URL $POSTDATA $CURLOPT -k -s -m$TIMEOUT | grep "$MATCH"
	RESULT=$?
	if [ $RESULT -eq 0 ]; then
	echo -e "\e[92m[*] Matched: $URL\e[0m"
	else
	echo -e "\e[91m[*] Not Matched: $URL\e[0m"
	fi
done
