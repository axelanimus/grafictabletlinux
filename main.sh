#!/usr/bin/env bash


declare -a options=('kernel' 'devices' 'parameters' 'modifiers' 'setButtons')

declare -a keyCombination=()

zenity --info  --title="Let's do it champion" --text='This script will gonna help you to manage some configurations of your grafic tablet, never give up, trust in me you can do anything that you can imagine.' --window-icon='resources/renewable-energy.png'


kernelCtl () {

	zenity --text-info --title="How to install the drivers for your grafic tablet" --html --url='https://github.com/DIGImend/digimend-kernel-drivers' --window-icon='resources/optimistic.png' --width='600' --height='600'; main

}


devicesCtl () {

	xsetwacom --list| sed 's/id:/\n/g;s/type:/\n/g'| zenity --list --title='Connected devices' --text="This are the detected devices, let's to create something amazing " --column='Device name' --column='id' --column='type' --width='500' --height='350' --window-icon='resources/tablet.png'; main

}


parametersCtl () {

	xsetwacom --list parameters | sed 's/-\ /\n/g'| zenity --list --title="This are the parameters that you can modify" --text="Remember that by now this section is just for see the parameters" --column='Parameters' --column='Function' --height=600 --width=1000 --window-icon='resources/control.png'; main


}


modifiersCtl () {

	xsetwacom --list modifiers| zenity --text-info --title='Keys supported' --width=300 --height=600 --window-icon='resources/teclado.png'; main
	
}


getShortCut () {
	
	modifiers=$(xsetwacom --list modifiers| sed '/ed:/d;/Keys/d;/^$/d'| zenity --list)

	keyCombination+=("$modifiers")

}



setButtonsCtl () {

	dispCtl=$(xsetwacom --list devices)

	if test -z $dispCtl; then

		zenity --info --title='There is not devices connected' --text='Looks like is not detected devices, maybe is bad connected, the wire is failing, the kernel module was not installed or your grafic tablet is imaginary so this program only works with fisic devices bro' --window-icon='resources/wire.png'
		main

	else

		unset $dispCtl

		zenity --text-info --html --title='Instructions of use this option' --checkbox='I promise by my mom and dad, my childrens, my family, my pet, by Chuck Norris, by my country, that I readed the instructions, If I did not that my pc burn' --filename='resources/instructions.html' --window-icon='resources/book.png'

		if [[ $? -eq 0 ]]; then

			device=$(xsetwacom --list devices| sed  's/id:/\nid:/g'| sed '/id:/d'| zenity --title='Detected devices' --text='Select a device for map its buttons'  --list --column='Aviable devices')

			id=$(xsetwacom --list devices| grep -ie "$device"| sed 's/id:/\nid:/g'| grep -e 'id:'| tr -c "[:print:]" " "| cut -d " " -f2)


			xinput --test $id| zenity --text-info --title='Push a button of your grafic tablet'

			buttonID=$(zenity --scale --title='Select the button number' --text='You must to select the button number that you want associate to a keyboard shortcut' --value=1 --min-value=1 --max-value=30 --window-icon='resources/button.png')

			until ! [ 0 ]; do

				getShortCut

				zenity --question --title='Answer wisely Einstein' --text='This are modifiers added to your shortcut:   $(echo ${keyCombination[*]})  Do you want add another?' --window-icon='resources/question.png'

				if [[ $? -ne 0 ]]; then

					break

				else

					continue

				fi

			done


			pureKeys=$(zenity --forms --title='Alphabet keys for your shortcut' --text="Right now this is your key shortcut for the button number $buttonID:  $(echo ${keyCombination[*]}| tr ' ' '+')" --add-entry='Insert one alphabet key or many separate by spaces') 

			zenity --question --title='Finally the last step' --text="This is your key shortcut for the button id $buttonID :  $(echo ${keyCombination[*]}| tr ' ' '+') + $(echo $pureKeys| tr ' ' '+')  Is correct?" --window-icon='resources/information.png'

			if [[ $? -eq 0 ]]; then

				xsetwacom --set "$device" Button $buttonID "key ${keyCombination[*]} $pureKeys" 

				zenity --info --window-icon='resources/ok.png'

				zenity --question --title='Sucess, we did it champion' --text="Do you want to map another button of your grafic tablet?" --window-icon='resources/ask.png'

				if ! [[ $? -ne 0 ]]; then

					setButtonsCtl

				else

					main

				fi

			else

				setButtonsCtl	

			fi


		else
			main

		fi

	fi
}



main () {

	mainWindow=$(echo ${options[*]}| tr ' ' '\n'| zenity --list --title='Here no one give up, animus' --text='Select an option' --column='Options' --window-icon='resources/artificial-intelligence.png' --width='275' --height='225'); [[ $? -ne 0 ]] && return 1


	
	case $mainWindow in

		"${options[0]}")
			kernelCtl
		;;

		"${options[1]}")
			devicesCtl
		;;

		"${options[2]}")
			parametersCtl
		;;

		"${options[3]}")
			modifiersCtl
		;;
			
		"${options[4]}")
			setButtonsCtl
		;;

	esac

}


main