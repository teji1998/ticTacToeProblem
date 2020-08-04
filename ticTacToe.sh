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

#Function to decide who will play first
playFirstToss()
{
	toss=$(( $RANDOM % 2 ))
	if [ $toss -eq 1 ]
	then
		echo "You have won the toss.You will play first."
	else
		echo "Computer has won the toss.Computer will play first."
	fi
}
boardReset
playFirstToss
