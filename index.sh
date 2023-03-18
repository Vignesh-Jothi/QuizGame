#!/bin/bash
while [ true ]; do
	echo "The Quiz Game"
	echo "1.Sign In"
	echo "2.Sign Up"
	echo "3.Exit"
	echo "Enter Your Choice: "
	read choice
	#Main Block
	if [ ! -d user ];then
		mkdir user
		mkdir user/Answers
	fi
	case $choice in
		1 )
			echo "Welcome to Sign In:"
			read -p "Enter Your User Name: " userName
			if [ -e user/$userName.txt ]
			then
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
					echo "Wrong password!"
				fi
			else
			  	echo "Kindly Sign Up !"
			fi;;
		2 )
			echo "Welcome to Sign Up:"
			read -p "Enter Your User Name: " userName
			if [ -e user/$userName.txt ]
			then
				echo "User Already Exists!"
			else
				echo "User Name: $userName " >> user/$userName.txt
				read -sp "Enter the password: " password
				echo "password: $password" >> user/$userName.txt
				echo $password
				echo "Sign Up Completed ! "
			fi;;
		3 )
			echo "Exiting....."
			exit 0;;
		* )
			echo "Wrong Input!"	
	esac
done
