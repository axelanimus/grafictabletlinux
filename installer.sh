#!/usr/bin/env bash

hash zenity

if [[ $? -ne 0 ]]; then
    
    echo -e "\033[1;4;31mZenity\e[0m is not installed, we need \033[1;4;31mZenity\e[0m for create the GUI"

    declare -a packcageM=$('apt' 'pacman' 'yum')

    declare -a options=('yes' 'not')

    PS3=$(echo -e "Select a number of option if do you want to install Zenity\n> ")
    select opt in ${options[*]}; do

        if [[ "$opt" = "yes" ]]; then
        
            printf "\033[1;32mzenity\033[0m will be install it also we gonna give a kiss to the keyboard now\nyes you, if you don\'t do it your pc will gonna do kabum is your choice 3, 2, 1\n ok do not rather we gonna give execution permisses to the main.sh script...\nAt least kiss the screen please\n"
            
            for pkgM in ${packcageM}; do

                hash pkgM
                if [[ $? -eq 0  ]]; then

                    packcageM=$pkgM
                    break
                fi
            
            done

            if test packcageM = 'apt'; then

                sudo apt update && sudo apt upgrade -y && sudo apt install zenity

            elif test packcageM = 'pacman'; then

                sudo pacman -Syu && pacman -S zenity

            elif test packcageM = 'yum'; then

                sudo yum update && sudo yum install zenity

            else 

                echo -e "Sorry looks like you haven\t installed any package manager support by this script you gonna need install zenity manually\nSorry litle Miguel Angel in pontecy...\n"

                return

            fi

            sudo chmod u+x $(dirname $(realpath $0))/main.sh
        
        else [[ "$opt" = "not" ]]
        
            echo -e "\nOk cuz looks like you have fear of be brave ese....Chales homie you only live once loco, maybe another time vato louco\n"    
        
        fi

    done

else
    printf "Cool you have installed zenity, congratulations you have the balls for run the main.sh script...Vatos locos for ever ese, viva la onda GnuLinux loco\n"

fi