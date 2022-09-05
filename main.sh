#!/usr/bin/env bash


declare -a options=(kernel devices parameters modifiers setButtons)

zenity --info  --title="Let's do it champion" --text='This script will gonna help you to manage some configurations of your grafic tablet, never give up, trust in me you can do anything that you can imagine.' --window-icon='resources/renewable-energy.png'


main () {

	mainWindow=$(echo ${options[*]}| tr ' ' '\n'| zenity --list --title='Here no one give up, animus' --text='Select an option' --column='Options' --window-icon='resources/artificial-intelligence.png' --width='275' --height='225')
	
	case $mainWindow in

		"${options[0]}")
			kernelCtl()
		;;

		"${options[1]}")
			devicesCtl()
		;;

		"${options[2]}")
			parametersCtl()
		;;

		"${options[3]}")
			modifiersCtl()
		;;
			
		"${options[4]}")
			setButtonsCtl()
		;;

	esac


}




kernelCtl () {

	zenity --text-info --title="How to install the drivers" --html --url='https://github.com/DIGImend/digimend-kernel-drivers' --window-icon='resources/optimistic.png' --width='600' --height='600'; main()

}


devicesCtl () {



}


parametersCtl () {



}


modifiersCtl() {


	
}


setButtonsCtl() {


	
}