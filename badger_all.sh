#!/bin/bash

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`
for D in *; do
    if [ -d "${D}" ]; then
        echo "Processing ${D}"
        ./badger.sh $D
    fi
done
