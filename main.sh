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


main()


kernelCtl () {

	zenity --text-info --title="How to install the drivers for your grfafic tablet" --html --url='https://github.com/DIGImend/digimend-kernel-drivers' --window-icon='resources/optimistic.png' --width='600' --height='600'; main()

}


devicesCtl () {

	xsetwacom --list| sed 's/id:/\n/g;s/type:/\n/g'| zenity --list --title='Connected devices' --text="This are the detected devices, let's to create something amazing " --column='Device name' --column='id' --column='type' --width='500' --height='350' --window-icon='resources/tablet.png'; main()

}


parametersCtl () {



}


modifiersCtl() {


	
}


setButtonsCtl() {


	
}



# xsetwacom --list parameters | sed 's/-\ /\n/g'| zenity --list --column='Parameters' --column='Function'