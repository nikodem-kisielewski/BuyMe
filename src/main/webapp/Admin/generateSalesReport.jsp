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
			<script type="text/javascript">
			$(document).ready(function() {
			    $('#data_type').bind('change', function() {
			        var elements = $('div.container').children().hide(); // hide all the elements
			        var value = $(this).val();

			        if (value.length) { // if somethings' selected
			            elements.filter('.' + value).show(); // show the ones we want
			        }
			    }).trigger('change');
			});
			</script>

			<div id="div1" style="display:none">
				<select size="1" id="val_type" title="" name="Value Type">
				<option value="item_id">By Item ID</option>
				<option value="item_type">By Item Type</option>
				<option value="seller_id">By Username</option>
			</select></br>
			Info: <input type="text" name="info"/> <br/>
			</div>
			<input type="submit" value="Submit"/>
			</form>
		</div>
	</body>
</html>