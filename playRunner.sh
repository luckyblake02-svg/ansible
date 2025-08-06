#!/bin/bash

base=<path>
dockerls=`ls DockerBooks/`
sshls=`ls SSHBooks/`
updatels=`ls UpdateBooks/`
testls=`ls TestBooks/`
declare -a shelf

bookshelf() {

PS3=`echo "Please select a choice (Type Quit to stop): "`

select opt in "Docker Books" "SSH Books" "Update Books" "Test Books" "Quit"; do

        case $opt in
                "Docker Books")
                        echo -e "Listing Docker books!\n" ; echo -e "$dockerls\n" ; echo "Would you like to run a book from here? (y/n)" ; read ans
                        break
                        ;;
                "SSH Books")
                        echo -e "Listing SSH Books!\n" ; echo -e "$sshls\n" ; echo "Would you like to run a book from here? (y/n)" ; read ans
                        break
                        ;;
                "Update Books")
                        echo -e "Listing Update Books!\n" ; echo -e "$updatels\n" ; echo "Would you like to run a book from here (y/n)" ; read ans
                        break
                        ;;
                "Test Books")
                        echo -e "Listing Test Books!\n" ; echo -e "$testls\n" ; echo "Would you like to run a book from here (y/n)" ; read ans
                        break
                        ;;
                "Quit")
                        echo -e "Quitting!\n" ; exit 0
                        break
                        ;;
                *) echo -e "No valid option selected. Restarting\n" ; bookshelf ;;
        esac
done

}

inventory() {

PS3=`echo "Please select your inventory file: "`

select inv in "Normal Inventory" "Test Inventory" "Quit"; do

        case $inv in
                "Normal Inventory")
                        selinv=<path>/inventory.yml ; echo -e "Selected normal inventory!\n"
                        break
                        ;;
                "Test Inventory")
                        selinv=<path>/TestBooks/testinv.yaml ; echo -e "Selected test inventory!\n"
                        break
                        ;;
                "Quit")
                        echo -e "Quitting!" ; exit 0
                        break
                        ;;
                *) echo -e "You forgot to make a selection\n" ; inventory ;;
        esac
done

}

echo -e "Welcome to Ansible --REDACTED--! Would you like to take a look at our libraries? (Default: Yes)" ; read check

if [ -z $check ]; then
        echo -e "\nExcellent!\n" ; bookshelf
        else echo -e "\nMaybe another time!" ; exit 0
fi

lsexec=`echo $opt | sed 's/ //'`

case $ans in
        "y")
                echo -e "Which book would you like to run (Type Quit to Stop):" ; ls $lsexec ; read choice
                shelf=($(ls $lsexec))
                if [[ ! " ${shelf[@]} " =~ " ${choice} " ]]; then
                        echo -e "Okay, stopping execution.\n" ; exit 0
                else inventory ; exec ansible-playbook "$base$lsexec/$choice" -i "$selinv" -v --vault-pass-file "$passPath" > Log.txt
                fi
                break
                ;;
        "n")
                echo -e "\nAlright. Returning to the menu.\n" ; bookshelf
                break
                ;;
        *) echo -e "\nInvalid option entered. Please try again.\n" ; bookshelf
esac
