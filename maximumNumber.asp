<!-- FILE          : maximumNumber.asp -->
<!-- PROJECT       : Assignment 4 -->
<!-- PROGRAMMERS   : Kyle Dunn, David Czachor -->
<!-- FIRST VERSION : 2022-10-17 -->
<!-- PURPOSE       :  This page validates the maximum number to use for the Hi-Lo game -->

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
                document.getElementById("errorMaxNumber").style.display = 'none';

                var maxNumberInput = document.getElementById("inputMaxNumber").value;

                if (maxNumberInput.trim().length == 0 || isNaN(maxNumberInput)) {
                    document.getElementById("errorMaxNumber").style.display = '';

                    event.preventDefault();
                }
            }
        </script>
    </head>

    <body>

        <%
            // Check to see if playerName is in cookies
            dim playerName

            playerName = Request.Cookies("playerName")

            // Redirects page to start if playerName couldn't be found
            if (playerName = "") then
                Response.Redirect("hiloStart.html")
            end if

            dim maxNum

            // Gets the maximum number
            maxNum = Request.Form("maximumNumber")
            if (maxNum <> "") then
                Response.Cookies("maximumNumber") = maxNum
            else
                maxNum = Request.Cookies("maximumNumber")
            end if
        %>

        <form action="maximumNumber.asp" method="post" onsubmit="validateInput(event);" name="MaxNumberForm">
            <div>
                Hello <%=playerName%>, please enter maximum number to use
                <input id="inputMaxNumber" type="number" name="maximumNumber">
                <input type="submit" value="Submit">
                <% if (maxNum="" ) then %>
                    <p id="errorMaxNumber" class="errorMsg" style="display: none;">Incorrect characters used.</p>
                <% elseif (IsNumeric(maxNum)=true and ((Int(maxNum) <= 1) or (Int(maxNum)>= 1000000))) then %>
                    <p id="errorMaxNumber" class="errorMsg">Max number out of range (2 - 1,000,000)</p>
                <% else %>
                    <% Response.Redirect("gameLoop.asp") %>
                <% end if %>
            </div>
        </form>
    </body>
</html>