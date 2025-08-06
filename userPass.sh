#!/bin/bash

echo "Grabbing new user password for vault storage..."
echo ""

echo "Are you ready for the user password? (Default: Yes)"
read answer
echo ""

pass=`cat <path>/.vault/newpass.txt | sed 's/salt.*//'`

if [ -z $answer ]; then
        echo "###############################################" &
        echo "########## Copy this somewhere safe! ##########" &
        echo "###############################################" &
        echo "" & echo "" &
        echo "su_password: $pass"
        else echo "Re-Run this when you are ready" & exit 0
fi

rm <path>/.vault/newpass.txt
