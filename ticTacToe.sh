#!/bin/bash

echo "WELCOME TO THE TIC-TAC-TOE GAME."

#Declaring an array
declare -a board

#Function for resetting the board
boardReset()
{
	for (( position=1 ; position<=9 ; position++ ))
	do
		board[$position]=" - "
	done
	echo "The resetting of board is done."
}
boardReset

