while [ true ];do
		if [ $userName ];then
			welcomeName=$userName
		else
			welcomeName=$newUserName
		fi
		echo "---------- Welcome $welcomeName ----------"
		echo "1.Play Game"
		echo "2.Change User Name"
		echo "3.Delect Account"
		echo "4.Logout"
		read gamechoice
		case $gamechoice in 
			1 )
				echo "---------- Welcome To the Game ----------"
				if [ -e quiz/quiz.txt ]
				then
					a=1
					score=0
					while [ $a -lt 4 ];do 
						head -n 5 quiz/$a.txt
						echo " "
						read -p "Enter the answer: " answer
						echo "$a) $answer" >> user/Answers/"$userName Answer.txt"
						chkAns=`grep "$a) $answer" quiz/orgAns.txt`
						if [[ $chkAns == "$a) $answer" ]];then
							score=`expr $score + 1`
						else
							score=`expr $score + 0`
						fi
						a=`expr $a + 1`
						echo " "
					done
					echo "Your Score is : " $score
					echo " "
				fi;;
			2 )
				echo "---------- Change User Name ----------"
				read -p "Enter the new user name: " newUserName
				if [ -e user/$userName.txt ];then
					mv -i user/$userName.txt user/$newUserName.txt
					echo "User Name: $newUserName " > user/$newUserName.txt
					echo "password: $password" >> user/$newUserName.txt
					echo "User name changed Sucessfully."
					bash index.sh
					exit 1
				else
					echo "Error: Kindly Check! user exist."
				fi;;
			3 )
				echo "---------- Delect Account ----------"
				if [ -e user/$userName.txt ];then
					rm user/$userName.txt
					echo "Account Delected." 
					bash index.sh
					exit 0
				else
					echo "Error: Kindly Check! user name."
				fi;;
			4 ) 
				bash index.sh
				exit 1;;
			* )
				echo "Error: Kindly Check Your choice."
		esac
done