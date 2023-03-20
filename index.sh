#!/bin/bash
while [ true ]; do
	#menuBlock
	clear
	width=$COLUMNS
	printf "\033[33m"
	string="The Quiz Game"
	printf "%$(((width-${#string})/2))s%s\n" "" "$string"
	sleep 0.2
	string="1.Login"
	printf "%$(((width-${#string})/2))s%s\n" "" "$string"
	sleep 0.3
	string="2.Sign Up"
	printf "%$(((width-${#string})/2))s%s\n" "" "$string"
	sleep 0.2
	string="3.Exit"
	printf "%$(((width-${#string})/2))s%s\n" "" "$string"
	sleep 0.3
	printf "\033[0m"
	echo "Enter Your Choice: "
	read choice
	#Creation Block
	if [ ! -d user ];then
		mkdir user
	fi
	#function Block 
	function login(){
		sleep 0.5
		clear
		printf "\033[33m"
		string="--------------- Welcome to Sign In ---------------"
		printf "%$(((width-${#string})/2))s%s\n" "" "$string"
		printf "\033[0m"
		read -p "Enter Your User Name: " userName
		if [ -e user/$userName.txt ]
		then
			chkUserName=`grep "User Name: $userName " user/$userName.txt `
			if [[ $chkUserName == "User Name: $userName " ]]; then
				read -sp "Enter Your password: " password
				echo $password
				chkPassword=`grep "password: $password" user/$userName.txt `
				if [[ $chkPassword == "password: $password" ]]
				then
					logindate=$(date) 
					echo "Last Login : ${logindate}" >> user/$userName.txt
					. ./quiz.sh
					bash quiz.sh 
				else
					echo " "
					printf "\033[91mWrong password!\033[0m"
					sleep 2
					login
				fi
			else
				echo "  "
				printf "\033[91mSomething Wrong! Kindly Check your user name\033[0m"
				sleep 2
			fi
		else
		  	echo ""
		  	printf "\033[91mUser Not Exists! Try Again.\033[0m"
		  	sleep 2
		  	echo " "
		  	read -p "1.Try Again | 2.Signup :" logch
		  	if [[ $logch = 1 ]]; then
		  		login
		  	elif [[ $logch = 2 ]];then
		  		  SignUp
		    else
		    	echo "Default SignUp!"
		    	SignUp
		  	fi
		fi
	}
	function SignUp(){
			sleep 0.5
			clear
			printf "\033[33m"
			string="--------------- Welcome to Sign Up ---------------"
			printf "%$(((width-${#string})/2))s%s\n" "" "$string"
			sleep 0.3
			printf "\033[0m"
			read -p "Enter Your User Name: " userName
			if [ -e user/$userName.txt ]
			then
				printf "\033[91mUser Already Exists! Try Again.\033[0m"
				sleep 2
				SignUp
			else
				echo "User Name: $userName " >> user/$userName.txt
				read -sp "Enter the password: " password
				echo "password: $password" >> user/$userName.txt
				echo $password
				printf "\033[92mSign Up Completed! Login to play the quiz.\033[0m "
				sleep 2
			fi
	}
	#mainBlock
	case $choice in
		1 )
			login;;
		2 )
			SignUp;;
		3 )
			echo "Exit Successfully." 
			exit 0;;
		* )
			printf "\033[91mWrong Input!\033[0m"
			sleep 0.7
	esac
done