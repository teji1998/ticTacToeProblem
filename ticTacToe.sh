#!/bin/bash

echo "WELCOME TO THE TIC-TAC-TOE GAME."

#Length of grid
LENGTH_OF_GRID=9

#Declaring an array
declare -a board

#declaring an variable
shiftChange=0
gameStatus=0
wonByComputer=0
wonByPlayer=0
turn=1


#Function for resetting the board
boardReset()
{
	for (( position=1 ; position<=LENGTH_OF_GRID ; position++ ))
	do
		board[$position]=$position
	done
	echo "The resetting of board is done."
	displayBoard
}

#To display the board
displayBoard()
{
	echo " ${board[1]} | ${board[2]} | ${board[3]} "
	echo " ${board[4]} | ${board[5]} | ${board[6]} "
	echo " ${board[7]} | ${board[8]} | ${board[9]} "
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

#To declare the winner
gameWinner()
{
	if [ $player -eq 1 ]
	then
		wonByPlayer=1
	else
		wonByComputer=1
	fi
	gameStatus=1
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
	elif [[ ${board[1]} != 1 && ${board[2]} != 2 && ${board[3]} != 3 && ${board[4]} != 4 && ${board[5]} != 5 && ${board[6]} != 6 && ${board[7]} != 7 && ${board[8]} != 8 && ${board[9]} != 9  ]]
 	then
		echo "Game ends.Its a tie."
		gameStatus=1;
	else
		echo "Continue the game."
	fi
}	

#chance of computer
computerChance()
{
	
	findComputerWin

	if [ $shiftChange -eq 0 ]
	then
		findPlayerWin
	fi	
	if [ $shiftChange -eq 0 ]
	then
		cornerPosition
	fi
	if [ $shiftChange -eq 0 ]
	then
		centerPosition
	fi

	if [ $shiftChange -eq 0 ]
	then
		randomPosition
	fi
	
}

#Chance of player
playerChance()
{
	read -p "Enter the position you want to add the letter : " temp
	while [[ ($(( ${board["$temp"]} )) -eq $(($computerLetter))) ||  ($(( ${board["$temp"]} )) -eq $(($playerLetter))) ]]  
	do
		echo "The position you choose is already occupied.Choose another spot"
	read -p "Again choose the position to add the letter $playerLetter: " temp
	done
	board[$temp]=$playerLetter
	echo "The letter chosen by player is ${board[$temp]}"
}

#declare winner
winner()
{
if [[ $wonByComputer == 1 ]]
      then
         displayBoard
         echo "game won by computer"
      elif [[ $wonByPlayer == 1 ]]
      then
         displayBoard
         echo "game won player"
      fi
}
#To play the game
playGame()
{
	boardReset
	playFirstToss
	gameStatus=0
	wonByPlayer=0
	while [ $gameStatus -ne 1 ]
	do
		displayBoard	
		if [ $player -eq 1 ]
		then
			playerChance
			findWinner
			player=0
			
		else
			computerChance
			findWinner
			player=1
		fi
		winner
	done

}

#block computer move
findComputerWin()
if [[ $position -le LENGTH_OF_GRID && $turn -le LENGTH_OF_GRID ]] 
then
   	if [[ ${board[$position]} == $position ]]
        then
      		board[$position]=$computerLetter
        	 findWinner
        	 if [[ $wonByComputer == 1 ]]
        	 then
         		shiftChange=1
               		wonByComputer=0
            		echo "Computer Chose:" $position
			break;
         	  else
            		board[$position] == $position
			
          	  fi
	 fi
	position=$((position+1))
	turn=$((turn+ 1 ))
fi

#Function to block user
function findPlayerWin()
{
	if [[ $position -le $GRID_OF_LENGTH && $turn -le LENGTH_OF_GRID ]]
        then
   		if [[ ${board[$position]} == $position ]]
  		then
   			board[$position]=$playerLetter
      			findWinner
      			if [[ $wonByPlayer == 1 ]]
      			then
         			shiftChange=1
         			wonByPlayer=0
         			board[$position]=$computerLetter
			else	
				board[$position] = $position 
     			 fi
   		 fi
		position=$((position+1))
		turn=$(( turn + 1 ))
        fi
}


#Function to get available corner
function getCorner()
{
	for ((i=1; i<=9; i=$(( i + 2)) ))
   do
	   if [[ $i = 5 ]]
   	then
   		continue
   	else
			if [[ ${positions[$i]} == $i ]]
   		then
				echo $wonByComputer
				findWinner
				wonByComputer=0
     			shiftChange=1
     			board[$position]=$computerLetter
   	  		break
   		fi
		fi
   done
}


#Function to get available corner
cornerPosition()
{
	for ((position=1; position<=LENGTH_OF_GRID; position=$(( position + 2)) ))
	do
		if [[ $position = 5 ]]
   		then
   			continue
   		else
			if [[ ${positions[$position]} == $position ]]
   			then
				echo $wonByComputer
				checkWin
				wonByComputer=0
     				shiftChange=1
     				board[$position]=$computerLetter
   	  			break
   			fi
		fi
   	done
}
#Function to get center position
centerPosition()
{
	if [[ $position = 5 ]]
   	then
		echo $wonByComputer
		checkWin
		wonByComputer=0
     		shiftChange=1
     		board[$position]=$computerLetter
 	 	break
   	fi
}
	
#Random Position
randomPosition()
{
	option=$(( ($RANDOM % $LENGTH_OF_GRID) + 1 ))
		while [[ ($(( ${board["$option"]} )) -eq $(($playerLetter))) || ($(( ${board["$option"]} )) -eq  $(($computerLetter))) ]]
		do
			option=$(( ($RANDOM % $LENGTH_OF_GRID) + 1 ))
		done
		computerPosition=$option
		echo "Position of computer is : " $computerPosition
		board[$computerPosition]=$computerLetter			
		echo The letter chosen by computer is ${board[$computerPosition]}
		displayBoard
}
playGame