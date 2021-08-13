<!DOCTYPE html>
<html>
	<head>
		<title>Generate Sales Report</title>
	</head>
	<body>
		<h1>Generate Sales Report</h1>
		<div>
		<form action="fetchReport.jsp" method="POST">
Data Type: <select size="1" id="data_type" title="" name="Data Type">
				<option value="total_earnings">Total Earnings</option>
				<option value="earnings_by_category">Earnings By Category</option>
				<option value="best_items">Best Items</option>
				<option value="best_sellers">Best Sellers</option>
			</select></br>
			 <input type="submit" value="Submit"/></br>
			 <a href='adminMain.jsp'>Go back to Admin Main Page</a>
			 </form>
			</div>
			
	</body>
</html>