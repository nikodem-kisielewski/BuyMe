<!DOCTYPE html>
<html>
	<head>
		<title>BuyMe Customer Service</title>
	</head>
	<body>
		<h1>Customer Service</h1>
		<div>
			<a>Ask a Question</a><br/>
			<a href="endUnansweredQuestions.jsp">My Unanswered Questions</a><br/>
			<a href="endAnsweredQuestions.jsp">My Answered Questions</a>
		</div>
		<br/>
		<div>
		<form action="addQuestion.jsp" method="POST">
			Question:	<input type="text" maxlength="200" size="130" name="question"/><br/><br/>
			
			<input type="submit" value="Submit"/>
			</form>
		</div>
	</body>
</html>