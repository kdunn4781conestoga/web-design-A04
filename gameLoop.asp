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
    
    <%
        dim playerName

        // Check for player name
        playerName = Request.Cookies("playerName")

        // Redirects page to start if playerName couldn't be found
        if (playerName = "") then
            Response.Redirect("hiloStart.html")
        end if

        dim maxNumber

        // Check for maximum number
        maxNumber = Request.Cookies("maximumNumber")

        // Redirects page to start if maximumNumber couldn't be found
        if (maxNumber = "") then
            Response.Redirect("maximumNumber.asp")
        elseif IsNumeric(maxNumber)=true then
            maxNumber = Int(maxNumber)
        end if

        dim minNumber

        // Check if the minimum number is a cookie
        // If none can be found then sets it to 1
        minNumber = Request.Cookies("minimumNumber")
        if (minNumber = "" or IsNumeric(numberToGuess)=false) then
            minNumber = 1
            Response.Cookies("minimumNumber") = minNumber
        elseif IsNumeric(minNumber) then
            minNumber = Int(minNumber)
        end if

        dim numberToGuess

        // Check if the number to guess is a cookie
        // Generates a random number if none can be found
        numberToGuess = Request.Cookies("numberToGuess")
        if (numberToGuess = "" or IsNumeric(numberToGuess)=false) then
            Randomize 
            numberToGuess = Int((maxNumber-minNumber+1)*Rnd+minNumber)
            Response.Cookies("numberToGuess") = numberToGuess
        elseif IsNumeric(numberToGuess) then
            numberToGuess = Int(numberToGuess)
        end if        

        dim playerGuess

        // Check for player's guess
        playerGuess = Request.Form("playerGuess")
        if (playerGuess <> "") then
            Response.Cookies("playerGuess") = playerGuess
        
            // Game Logic
            dim errorMessage

            if (Int(playerGuess) < minNumber or Int(playerGuess) > maxNumber) then
                errorMessage = "Incorrect range used"
            elseif Int(playerGuess) < numberToGuess then
                errorMessage = "Incorrect guess, number is higher"
                minNumber = Int(playerGuess) + 1
                Response.Cookies("minimumNumber") = minNumber
            elseif Int(playerGuess) > numberToGuess then
                errorMessage="Incorrect guess, number is lower" 
                maxNumber=Int(playerGuess) - 1
                Response.Cookies("maximumNumber")=maxNumber
            else
                Response.Redirect("gameEnd.asp")
            end if
        else
            playerGuess = Request.Cookies("playerGuess")
        end if
    %>

    <body>
        <form action="gameLoop.asp" method="post" onsubmit="validateInput(event);" name="GuessForm">
            <div>
                Enter a number between <%=minNumber%> and <%=maxNumber%>
                <input id="inputPlayerGuess" type="number" name="playerGuess">
                <input type="submit" value="Submit">
                <% if (playerGuess = "") then %>
                    <p id="errorPlayerGuess" class="errorMsg" style="display: none;">Invalid characters used for number.</p>
                <% elseif IsNumeric(playerGuess)=true then %>
                    <p id="errorPlayerGuess" class="errorMsg"><%=errorMessage%></p>
                <% end if %>
            </div>
        </form>
    </body>
</html>