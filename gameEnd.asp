<!-- FILE          : gameEnd.asp -->
<!-- PROJECT       : Assignment 4 -->
<!-- PROGRAMMERS   : Kyle Dunn, David Czachor -->
<!-- FIRST VERSION : 2022-10-17 -->
<!-- PURPOSE       :  This page is the win screen with the option to play again -->

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Hi-Lo Game</title>
        <link rel="stylesheet" href="styles.css">
    </head>

    <body class="win">
        <%
            // Check to see if playerName is in cookies
            dim playerName

            playerName = Request.Cookies("playerName")

            // Redirects page to start if playerName couldn't be found
            if (playerName = "") then
                Response.Redirect("hiloStart.html")                 
            end if

            
            // Check for maximum number
            maxNumber = Request.Cookies("maximumNumber")
            // Check for player guess
            playerGuess = Request.Cookies("playerGuess")

            // Redirects page to start if playerName couldn't be found
            if (maxNumber = "") then
                Response.Redirect("maximumNumber.asp")
            else if (playerGuess <> playerGuess) then
                Response.Redirect("gameLoop.asp")
            end if
            end if

            // Resets Cookies
            Response.Cookies("maximumNumber").Expires = DateAdd("d",-1,Now())
            Response.Cookies("minimumNumber").Expires = DateAdd("d",-1,Now())
            Response.Cookies("numberToGuess").Expires = DateAdd("d",-1,Now())
        %>

        <form action="maximumNumber.asp" method="post" name="MaxNumberForm">
            <div>
                You Win!! You guessed the number!!
                <input type="submit" id="playAgain" value="Play Again">
            </div>
        </form>
    </body>
</html>