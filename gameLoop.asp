<!-- FILE          : gameLoop.asp -->
<!-- PROJECT       : Assignment 4 -->
<!-- PROGRAMMERS   : Kyle Dunn, David Czachor -->
<!-- FIRST VERSION : 2022-10-17 -->
<!-- PURPOSE       : This page runs the main loop for the game, checking to see
                     if the number that the user inputted is valid. -->

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hi-Lo Game</title>
        <link rel="stylesheet" href="styles.css">

        <script>
            // Function   : validateInput()
            // Purpose    : This function validates the information depending on the
            //              section it is on
            // Parameters : event : used for preventing the form from submitting
            function validateInput(event) {
                document.getElementById('errorPlayerGuess').style.display = 'none';

                var playerGuessInput;

                // Check username input
                playerGuessInput = document.getElementById("inputPlayerGuess").value;

                if (playerGuessInput.trim().length == 0 || isNaN(playerGuessInput)) {
                    document.getElementById('errorPlayerGuess').style.display = '';

                    event.preventDefault();
                } else {
                    document.cookie = `playerGuess=${playerGuessInput};`;
                }
            }
        </script>
    </head>

    <body>
        <form action="gameLoop.asp" method="post" onsubmit="validateInput(event);" name="GuessForm">
            <div>
                Enter a number between _ and _
                <input id="inputPlayerGuess" type="number" name="playerGuess">
                <input type="submit" value="Submit">
                <p id="errorPlayerGuess" class="errorMsg" style="display: none;">Invalid characters used for number.</p> 
            </div>
        </form>
    </body>
</html>