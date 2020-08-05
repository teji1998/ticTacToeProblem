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
		echo "You have won the toss.You will play first."
		choosePlayerLetter
	else
		echo "Computer has won the toss.Computer will play first."
		chooseComputerLetter
	fi
	echo "Letter chosen by player is : $playerLetter"
	echo "Letter chosen by computer is : $computerLetter"
}
boardReset
playFirstToss

