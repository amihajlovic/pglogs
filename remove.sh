# !/bin/bash

DB=${1}
DIR=${DB}/logs

find ${DIR} -type f -regextype posix-egrep -regex ".*postgresql\.log\.[0-9]{4}-[0-9]{2}-[0-9]{2}-[0-9]{2}\.gz" -exec bash -c 'fn=${0##*/}; d=${fn:15:-6}; dd=$(date -d $d +%s); [[ $dd -le $(date -d "now - 7 days" +%s) ]] && rm -f $0' {} \;

