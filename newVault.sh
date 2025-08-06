#!/bin/bash

get<passVault>Pass() {

echo ""
echo "###################################################"
echo "#######   Grabbing <password vault> Password   #######"
echo "###################################################"
echo ""
echo "Requesting an access token..."
echo ""

accessToken=`curl -s --request GET -H "Content-Type: application/x-www-form-urlencoded" -d "grant_type=password" -d "username=<username>" -d "password=<password>" --url <url>`

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

}

echo "Creating an Ansible Vault..."
echo ""


echo "Please enter the new password for the vault (Default: <password vault> Password)"

read -s vaultpass

if [ -z $vaultpass ]; then
    	echo "No password entered, running <passowrd vault> function..."
    	get<passVault>Pass

    	else echo "Got the new password." & echo ""
fi


echo "The password will display one time for you to copy. Are you ready? (Default: Yes)"
read ready
echo ""

until [ -z $ready ]
do
    	echo "Press enter when you are ready" & read ready
done

echo "The password is: $response"
echo ""
echo "Write it into the vault as su_password: password"

rm <path>/.vault/secrets.yaml
exec ansible-vault create <path>/.vault/secrets.yaml
