<?php

class MyTable 
{
	
	protected $link;

	function connectDB ($hostname, $username, $password, $dbName)
	{
		$this->link = mysqli_connect($hostname, $username, $password, $dbName);
    	if (mysqli_connect_errno()) {
      		return False;
    	} else {
     		mysqli_query($this->link, "set CHARACTER SET UTF8");
      	return True;
    	}
	}

	function closeConnect ()
	{
		mysqli_close($this->link);
	}
//&darr; &uarr;

	function getQueryText ($colom, $type)
	{	
		if ($colom == 'numeric') $colom = 'numeric_';
		if ($type == 'up') {
			$type = 'DESC';
			return "select * from test_table order by $colom $type";
		} else {
			return "select * from test_table order by $colom";
		}
		
	}

	function getSearchForm($selected, $text)
	{
		switch ($selected) {
			case 'alphabetic': $aplphabetic = 'selected'; break;
			case 'numeric_': $numeric = 'selected'; break;
			case 'date': $date = 'selected'; break;
			case 'unsortable': $unsortable = 'selected'; break;
		}
		echo "\t<form action=\"test_table.php\" method=\"post\">\n
			\t\t<select name=\"select\">\n
				\t\t\t<option $aplphabetic value=\"alphabetic\">Alphabetic</option>\n
				\t\t\t<option $numeric value=\"numeric_\">Numeric</option>\n
				\t\t\t<option $date value=\"date\">Date</option>\n
				\t\t\t<option $unsortable value=\"unsortable\">Unsortable</option>\n
			\t\t</select>\n
			\t\t<input type=\"text\" name=\"text\" value=\"$text\">\n
			\t\t<input type=\"submit\" value=\"GO\">\n
		\t</form>\n";
		return true;
	}
	function getTable ($sorted, $type, $text)
	{
		if ($type==NULL)  {
			$type = "up";
			$symbol = "&darr;";
		} else {
			switch ($type) {
				case 'up':	$type = "down"; $symbol = "&uarr;"; break;
				case 'down': $type = "up"; $symbol = "&darr;"; break;
			}
		}
		switch ($sorted) {
			case 'alphabetic': $alphabetic = $symbol; break;
			case 'numeric': $numeric = $symbol; break;
			case 'date': $date = $symbol; break;
			case 'unsortable': $unsortable = $symbol; break;
		}
		//выбирается какой будет текст запроса
		//если не сортируем и не проводим поиск, то обычный вывод всей таблицы
		if ($sorted == NULL and $text == NULL)
			$query = "select * from test_table";
		//если нет строки поиска, то сортировка
		elseif ($text == NULL)
			$query = $this->getQueryText($sorted, $type);
		//иначе поиск
		else
			$query = "select * from test_table where $sorted = '$text'";

		$result = mysqli_query($this->link, $query);
		$count = mysqli_num_rows($result);
		if ($count == 0) {
			echo "поиск не дал результатов";
			echo "<a href='/test_table.php'>исходная</a>";
			return true;
		}
		if ($result) {
			echo "<table border='1'>\n";
			echo "\t<tr class='table_header'>
				<th><a class='mycolor' href=\"/test_table.php?sorted=alphabetic&type=$type\">Alphabetic $alphabetic</a></th>
				<th><a class='mycolor' href=\"/test_table.php?sorted=numeric&type=$type\">Numeric $numeric</a></th>
				<th><a class='mycolor' href=\"/test_table.php?sorted=date&type=$type\">Date $date</a></th>
				<th><a class='mycolor' href=\"/test_table.php?sorted=unsortable&type=$type\">Unsortable $unsortable</a></th></tr>\n";
			while ($arr = mysqli_fetch_array($result)) {
				echo "\t\t<tr>";
				echo "<td align='center'>".$arr['alphabetic']."</td>";
				echo "<td align='center'>".$arr['numeric_']."</td>";
				echo "<td align='center'>".$arr['date']."</td>";
				echo "<td align='center'>".$arr['unsortable']."</td>";
				echo "</tr>\n";			
			}
			echo "</table>\n";
			return true;

		} else {
			echo $query;
			return false;
		}
	}

}
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>test</title>
	<style>
	a {
		text-decoration: none;
		display: block;
	}
	#table {
		margin-top:40px;
	}
	.table_header {
		background-color:#8BF49F;
	}
	.mycolor {
		color:#666;
	}
	#search_form {
		margin:0 auto;
		padding:20px;
		border:2px solid #777;
		width:320px;
		height:auto;
	}
	#search_form p{
		padding:0;
		margin:0;
		margin-bottom:5px;
	}

	</style>
</head>
<body>
<div id="search_form">
	<p class='mycolor'>поиск по столбцу</p>
	<?php
	$test = new MyTable ();
	if (isset($_POST['text'])) {
		$test->getSearchForm($_POST['select'], $_POST['text']);
	} else {
		$test->getSearchForm(NULL, '');
	}
	?>
</div>
<div id="table" align="center">
<?php
if ($test->connectDB('localhost', 'root', '', 'orders')) {
	//получаем имя колонки
	if (isset($_GET['sorted'])) $sorted = $_GET['sorted']; else $sorted = NULL;
	//получаем тип сортировки
	if (isset($_GET['type'])) $type = $_GET['type']; else $type = NULL;
	//если поиск
	if (isset($_POST['select']) and isset($_POST['text']) and $_POST['text'] != ''){
		$text = mysql_escape_string($_POST['text']);
		if (!$test->getTable($_POST['select'], NULL, $text))
			echo "gettable error";
	} elseif (isset($_POST['text']) and $_POST['text'] == '') {
		echo "поиск не дал результатов";
		echo "<a href='/test_table.php'>исходная</a>";
		exit();
	} else {
		if (!$test->getTable($sorted, $type, NULL))
			echo "gettable error";
	}
	
} else {
	echo "db connect error";
}
?>
</div>
</body>
</html>
