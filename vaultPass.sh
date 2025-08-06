#!/bin/bash

echo "Are you ready for the vault password? (Default: Yes)"
read answer
echo ""

if [ -z $answer ]; then
        echo "Okay! Moving on." & echo ""
        else echo "Re-Run this when you are ready" & exit 0
fi

echo ""
echo "###################################################"
echo "#######   Grabbing <password vault> Password   #######"
echo "###################################################"
echo ""
echo "Requesting an access token..."
echo ""

accessToken=`curl -s --request GET -H "Content-Type: application/x-www-form-urlencoded" -d "grant_type=password" -d "username=<user>" -d "password=<password>" --url <url>`

echo "Got the access token!"
echo ""

accessToken=`echo $accessToken | sed 's/{"access_token":"//'`
accessToken=`echo $accessToken | sed 's/","token_type.*//'`

echo "Requesting the password using the access token..."
echo ""

response=`curl -s --request GET -H "Authorization:Bearer $accessToken" -H "Content-Type: application/json" --url <url>`
response=`echo $response | jq '.items[3]' | jq '.itemValue' | sed 's/"//g'`

echo "Got the response!"
echo ""

echo "#########################################################"
echo "##### Copy the password in order to open the vault. #####"
echo "#########################################################"
echo ""

echo "The password will be stored in passPath"

echo $response > secret.txt
