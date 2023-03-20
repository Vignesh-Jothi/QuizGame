while [ true ];do
		#Creation Block
		width=$COLUMNS
		if [ $userName ];then
			welcomeName=$userName
		else
			welcomeName=$newUserName
		fi
		#functionBlock
		function quizMenu(){
				clear
				printf "\033[33m"
				string="--------------- Welcome To the Quiz Game ---------------"
				printf "%$(((width-${#string})/2))s%s\n" "" "$string"
				string="Rules:"
				printf "%$(((width-${#string})/2))s%s\n" "" "$string"
				string="1) Only Enter the A B C D options"
				printf "%$(((width-${#string})/2))s%s\n" "" "$string"
				string="All the best !"
				printf "%$(((width-${#string})/2))s%s\n" "" "$string"
				sleep 0.7	
				printf "\033[0m"
		}
		function playQuiz(){
				if [ -e quiz/1.txt ]
				then
					a=1
					score=0
					while [ -e quiz/$a.txt ];do
						quizMenu 
						if [ $a = 1 ];then
							for (( i=3; i>0; i--)); do
	  							sleep 1 &
	  							printf "Starts in $i \r"
	  							wait
							done
						fi
						cat quiz/$a.txt
						echo " "
						sleep 0.5
						read -p "Enter the answer: " answer
						if [ $answer = "A" -o $answer = "B" -o $answer = "C" -o $answer = "D" ];then
							echo "Correct Answer :" `sed "$a!d" quiz/orgAns.txt`     
							# echo "Your Answer $a) $answer"
							chkAns=`grep "$a) $answer" quiz/orgAns.txt`
							if [[ $chkAns == "$a) $answer" ]];then
								printf "\033[92mYour Answer $a) $answer"
								score=`expr $score + 1`
								printf "\n 👌 Correct! Nice.\033[0m"
								sleep 2
							else
								printf "\033[91mYour Answer $a) $answer"
								score=`expr $score + 0`
								printf "\n 😅 Incorrect! Sorry!\033[0m"
								sleep 2
							fi
							a=`expr $a + 1`
							sleep 1
						else
							echo "Use A,B,C,D Choice only."
							sleep 2
						fi
					done
					printf "\n\nYour Score is : $score/5"
					sleep 3
				fi
		}
		function changeUserName(){
				clear
				sleep 0.2
				printf "\033[33m"
				string="--------------- Change User Name ---------------"
				printf "%$(((width-${#string})/2))s%s\n" "" "$string"
				printf "\033[0m"
				read -p "Enter the new user name: " newUserName
				if [ ! -e user/$newUserName.txt ];then
					mv -i user/$userName.txt user/$newUserName.txt
					echo "User Name: $newUserName " > user/$newUserName.txt
					echo "password: $password" >> user/$newUserName.txt
					echo "User name changed Sucessfully."
					sleep 0.5
					login
					exit 1
				else
					printf "\033[91mError: Kindly Check! user exist.\033[0m"
					sleep 1
					changeUserName
				fi
		}
		function deleteAccount(){
				clear
				sleep 0.2
				printf "\033[33m"
				string="--------------- Delect Account ---------------"
				printf "%$(((width-${#string})/2))s%s\n" "" "$string"
				printf "\033[0m"
				if [ -e user/$userName.txt ];then
					rm user/$userName.txt
					string="Account Delected."
					printf "%$(((width-${#string})/2))s%s\n" "" "$string"
					sleep 2 
					clear
					bash index.sh
					exit 0
				else
					echo "Error: Kindly Check! user name."
					deleteAccount
				fi
		}
		function deleteConform(){
				printf "\033[91m"
				wrong="If you delete your account, Your data will be erased!"
				printf "%$(((width-${#wrong})/2))s%s\n" "" "$wrong"
				printf "\033[0m"
				echo " "
				read -p "Enter Your Choice: y/n " delch
				if [ $delch = "y" ];then
					deleteAccount
				elif [ $delch = "n" ];then
					echo "You try to delete your account! Kindly sign in to play the quiz."
					sleep 0.8
					login
				else
					printf "\033[91mWrong Input! Try Again.\033[0m"
					sleep 0.8
					deleteConform
				fi
		}
		#menuBlock
		clear
		printf "\033[33m"
		string="--------------- Welcome $welcomeName ---------------"
		printf "%$(((width-${#string})/2))s%s\n" "" "$string"
		sleep 0.3
		string="1.Play Game"
		printf "%$(((width-${#string})/2))s%s\n" "" "$string"
		sleep 0.2
		string="2.Change User Name"
		printf "%$(((width-${#string})/2))s%s\n" "" "$string"
		sleep 0.3
		string="3.Delect Account"
		printf "%$(((width-${#string})/2))s%s\n" "" "$string"
		sleep 0.2
		string="4.Logout"
		printf "%$(((width-${#string})/2))s%s\n" "" "$string"
		printf "\033[33m"
		echo "Enter Your Choice: "
		read gamechoice
		case $gamechoice in 
			1 )
				playQuiz;;
			2 )
				changeUserName;;
			3 )
				deleteConform;;
			4 ) 
				clear
				sleep 0.3
				bash index.sh
				exit 1;;
			* )
				echo "Error: Kindly Check Your choice."
				sleep 1
		esac
done