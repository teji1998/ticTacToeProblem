#!/bin/bash

echo "WELCOME TO THE TIC-TAC-TOE GAME."

#Length of grid
LENGTH_OF_GRID=9
#Declaring an array
declare -a board

#Function for resetting the board
boardReset()
{
	for (( position=1 ; position<=LENGTH_OF_GRID ; position++ ))
	do
		board[$position]=" - "
	done
	echo "The resetting of board is done."
}

#To choose X or 0 by player
choosePlayerLetter()
{
	read -p "Enter 0 for 'X' and 1 for '0': " letter
	if [ $letter -eq 1 ]
	then
		playerLetter='0'
		computerLetter='X'
	elif [ $letter -eq 0 ]
	then
		playerLetter='X'
		computerLetter='0'
	else
		echo "Not valid choice.Try again."
		choosePlayerLetter
	fi
}

#To choose X or 0 by computer
chooseComputerLetter()
{
	letter=$(( $RANDOM % 2 ))
	if [ $letter -eq 1 ]
        then
                computerLetter='0'
                playerLetter='X'
        else
                computerLetter='X'
              	playerLetter='0'
        fi
}

#Function to decide who will play first
playFirstToss()
{
	toss=$(( $RANDOM % 2 ))
	if [ $toss -eq 1 ]
	then
		player=1
		echo "You have won the toss.You will play first."
		choosePlayerLetter
	else
		player=0
		echo "Computer has won the toss.Computer will play first."
		chooseComputerLetter
	fi
	echo "Letter chosen by player is : $playerLetter"
	echo "Letter chosen by computer is : $computerLetter"
}

#To display the board
displayBoard()
{
	echo " ${board[1]} | ${board[2]} | ${board[3]} "
	echo " ----+-----+---- "
	echo " ${board[4]} | ${board[5]} | ${board[6]} "
        echo " ----+-----+---- "
	echo " ${board[7]} | ${board[8]} | ${board[9]} "
}

#To declare the winner
gameWinner()
{
	if [ $player -eq 1 ]
	then
		echo "You won."
	else
		echo "Computer won."
	fi
}

#To check the conditions to decide the winner
findWinner()
{
	if ([[ ${board[1]} == ${board[2]} && ${board[2]} == ${board[3]} ]]) ||
	   ([[ ${board[4]} == ${board[5]} && ${board[5]} == ${board[6]} ]]) ||
	   ([[ ${board[7]} == ${board[8]} && ${board[8]} == ${board[9]} ]]) ||
	   ([[ ${board[1]} == ${board[4]} && ${board[4]} == ${board[7]} ]]) ||
	   ([[ ${board[2]} == ${board[5]} && ${board[5]} == ${board[8]} ]]) ||
       	   ([[ ${board[3]} == ${board[6]} && ${board[6]} == ${board[9]} ]]) ||
	   ([[ ${board[1]} == ${board[5]} && ${board[5]} == ${board[9]} ]]) ||
	   ([[ ${board[7]} == ${board[5]} && ${board[5]} == ${board[3]} ]])
	then
		gameWinner
	elif [[  ! ${board[*]} =~ [-] ]]
 	then
		echo "Game ends.Its a tie."
	else
		echo "Continue the game."
	fi
}	

#chance of computer
computerChance()
{
	option=$(( ($RANDOM % $LENGTH_OF_GRID) + 1 ))
	while [ ${board[ $option ]} == [-] ]
	do
		option=$(( ($RANDOM % $LENGTH_OF_GRID) + 1 ))
	done
	computerPosition=$option
	echo "Position of computer is : " $computerPosition
	board[$computerPosition]=$computerLetter
	echo The letter chosen by computer is ${board[$computerPosition]}
}
boardReset
playFirstToss
displayBoard
findWinner
computerChance