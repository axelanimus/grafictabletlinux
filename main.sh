#!/usr/bin/env bash

#Array with the options for select
declare -a options=('kernel' 'devices' 'parameters' 'modifiers' 'setButtons')

#Array that gets the modifiers
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

	#Flow control for don´t run this option if there's not devices connected
	if test -z $dispCtl; then

		zenity --info --title='There is not devices connected' --text='Looks like is not detected devices, maybe is bad connected, the wire is failing, the kernel module was not installed or your grafic tablet is imaginary so this program only works with fisic devices bro' --window-icon='resources/wire.png'
		main

	#If there's connected devices run this
	else

		unset $dispCtl

		zenity --text-info --html --title='Instructions of use this option' --checkbox='I promise by my mom and dad, my childrens, my family, my pet, by Chuck Norris, by my country, that I readed the instructions, If I did not that my pc burn' --filename='resources/instructions.html' --window-icon='resources/book.png'

		if [[ $? -eq 0 ]]; then

			#Get device name
			device=$(xsetwacom --list devices| sed  's/id:/\nid:/g'| sed '/id:/d'| zenity --title='Detected devices' --text='Select a device for map its buttons'  --list --column='Aviable devices')

			zenity --question --title='Unmap buttons' --text='Do you want to clear the button map (This works if you already mapped the button before, yeah this clear the key or keyboard associated to any button for let it like the heart of your ex..Empty... You must to know the button id number of the button which gonna be unmap)????' --window-icon='resources/question.png'

			#For clear the button map if was mapped before
			if test 0 -eq $?; then

				buttonClearID=$(zenity --entry --title='Clear the button map' --text='Put here the id number of the button that you want to unmap')
				
				xsetwacom --set "$device" Button $buttonClearID "0"

				if [[ $? -eq 0  ]]; then

					zenity --info --title='Ajuaa...Mission complete' --text="The button  was unmap sucefully...Cool...Cool like the heart of your ex"  --window-icon='resources/ok.png'

				fi

			fi

			#Get the device id for use it with xinput command
			id=$(xsetwacom --list devices| grep -ie "$device"| sed 's/id:/\nid:/g'| grep -e 'id:'| tr -c "[:print:]" " "| cut -d " " -f2)

			zenity --info --title='Put atention here buddy' --text='Remember well...Again... REMEMBER WELL then of click on accept button in the next window you must to push the button of your grafic tablet again for continue with the program, in less words, then of click the accept button, the window gonna will desapair but the program still running and for appears the next window you must to push any button of your grafic tablet' --window-icon='resources/book.png'

			#Window for test the buttons and know its button id number
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