<cfscript>
function getFeedback(target, guess) {
    var feedback = "";
    for (var i = 1; i <= len(target); i++) {
        if (mid(target, i, 1) == mid(guess, i, 1)) {
            feedback &= "<span style='color:green'>" & mid(guess, i, 1) & "</span>";
        } else if (find(mid(guess, i, 1), target)) {
            feedback &= "<span style='color:orange'>" & mid(guess, i, 1) & "</span>";
        } else {
            feedback &= "<span style='color:red'>" & mid(guess, i, 1) & "</span>";
        }
    }
    return feedback;
}
</cfscript>

<cfif structKeyExists(form, "guess")>
    <cfset client.attempts++>
    <cfset feedback = getFeedback(client.targetWord, form.guess)>
</cfif>

<html>
<head>
    <title>ColdFusion Wordle</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Cold Wordle</h1>
    <cfif structKeyExists(form, "guess")>
        <p>Your guess: <cfoutput>#form.guess#</cfoutput></p>
        <p>Feedback: <cfoutput>#feedback#</cfoutput></p>
        <cfif form.guess eq client.targetWord>
            <p>Congratulations! You guessed the word!</p>
            <cfset structDelete(client, "targetWord")>
        <cfelseif client.attempts ge client.maxAttempts>
            <p>Sorry, you've run out of attempts. The word was <cfoutput>#client.targetWord#</cfoutput>.</p>
            <cfset structDelete(client, "targetWord")>
        </cfif>
    </cfif>

    <cfif !structKeyExists(client, "targetWord")>
        <form action="index.cfm" method="post">
            <input type="submit" value="Start New Game">
        </form>
    <cfelse>
        <form action="index.cfm" method="post">
            <label for="guess">Enter your guess:</label>
            <input type="text" name="guess" id="guess" maxlength="5" required>
            <input type="submit" value="Submit">
        </form>
        <p>Attempts: <cfoutput>#client.attempts# / #client.maxAttempts#</cfoutput></p>
    </cfif>
</body>
</html>