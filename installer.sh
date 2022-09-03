#!/usr/bin/env bash

hash zenity
if [[ $? -ne 0 ]]; then
    
    echo -e "\033[1;4;31mZenity\e[0m is not installed, we need \033[1;4;31mZenity\e[0m for create the GUI"

    declare -a options=('yes' 'not')

    PS3=$(echo -e "Select a number of option if do you want to install Zenity\n> ")
    select opt in ${options[*]}; do

        if [[ "$opt" = "yes" ]]; then
            printf "\033[1;32mzenity\033[0m will be install it"
            sudo apt update && sudo apt upgrade -y && sudo apt install zenity
        else [[ "$opt" = "not" ]]
            echo "Ok cuz looks like you have fear of be brave ese....Chales homie you only live once loco, maybe another time vato louco"    
        fi

    done

else
    printf "Cool you have installed zenity , congratulations, you have the balls for run the main.sh script...Vatos locos for ever ese, viva la onda GnuLinux loco\n"

fi