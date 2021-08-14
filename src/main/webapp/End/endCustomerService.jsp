<!DOCTYPE html>
<html>
	<head>
		<title>BuyMe Customer Service</title>
	</head>
	<body>
		<h1>Customer Service</h1>
		<div>
			<a href="endUnansweredQuestions.jsp">My Unanswered Questions</a><br/>
			<a href="endAnsweredQuestions.jsp">My Answered Questions</a><br>
			<a href="browseQuestions.jsp">Browse Questions</a><br>
			<a href="searchQuestions.jsp">Search Questions</a>
		</div>
		<br/>
		<div>
		<form action="addQuestion.jsp" method="POST">
			Question:	<input type="text" maxlength="200" size="130" name="question"/><br/><br/>
			
			<input type="submit" value="Submit"/>
			</form>
			<a href='endMain.jsp'>Go back to BuyMe Main Page</a>
		</div>
	</body>
</html>