#!/usr/bin/env bash


declare -a options=(kernel devices parameters modifiers setButtons help)

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

		"${options[5]}")
			helpCtl()
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

	xsetwacom --list parameters | sed 's/-\ /\n/g'| zenity --list --title="This are the parameters that you can modify" --text="Remember that by now this section is just for see the parameters" --column='Parameters' --column='Function' --height=600 --width=1000 --window-icon='resources/control.png'; main()


}


modifiersCtl() {

	xsetwacom --list modifiers| zenity --text-info --title='Keys supported' --width=300 --height=600 --window-icon='resources/teclado.png'
	
}


setButtonsCtl() {

	zenity --text-info --title='Instructions of use this option' --checkbox='I promise by my mom and dad, my childrens, my family, my pet, by Chuck Norris, by my country, that I readed the instructions, If I did not that my pc burn' --filename='resources/instructions.txt' --window-icon='resources/book.png'

	test [[ $? -eq 0 ]]; then
		
		device=$(xsetwacom --list devices| sed  's/id:/\nid:/g'| sed '/id:/d'| zenity --title='Detected devices' --text='Select an device for map its buttons'  --list --column='Aviable devices')

		id=$(xsetwacom --list devices| grep -ie "$device"| sed 's/id:/\nid:/g'| grep -e 'id:'| cut -d '  ' -f1| tr -d 'id:\ '

	else
		main()	

	fi

}


helpCtl () {



}

# zenity --text-info --title='Instructions of use this option' --checkbox='I promise by my mom and dad, my childrens, my family, my pet, by Chuck Norris, by my country, that I readed the instructions, If I did not that my pc burn' --filename='resources/instructions.txt' --window-icon='resources/book.png'

# ;devices=$(xsetwacom --list devices| sed  's/id:/\nid:/g'| sed '/id:/d'| zenity --title='Detected devices' --text='Select an device for map its buttons'  --list --column='Aviable devices')