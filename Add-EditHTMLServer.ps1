

# https://ej2.syncfusion.com/documentation/listview/how-to/add-and-remove-list-items-from-listview/
# https://www.w3schools.com/css/css_table_size.asp
# https://www.w3schools.com/css/tryit.asp?filename=trycss_form_responsive


Function Add-EditHTMLServer {
  param($ServerID = "2")


  # Get data from table Servers
  $FindServer = 'sqlite3 .\monitor.db3 -header "Select * from Servers WHERE ServerID={0}" | ConvertFrom-Csv -Delimiter "|"' -f $ServerID
  $Server = Invoke-Expression -Command $FindServer 
  $Server
  
### HTML Form
$form = @"
<!DOCTYPE html>
<html>
<head>
<style>
* {
  box-sizing: border-box;
}

input[type=text], select, textarea {
  width: 100%;
  padding: 12px;
  border: 1px solid #ccc;
  border-radius: 4px;
  resize: vertical;
}

label {
  padding: 12px 12px 12px 0;
  display: inline-block;
}

input[type=submit] {
  background-color: #0066ff;
  color: white;
  padding: 12px 20px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
  float: right;
}

input[type=submit]:hover {
  background-color: #45a049;
}

.container {
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}

.col-25 {
  float: left;
  width: 25%;
  margin-top: 6px;
}

.col-75 {
  float: left;
  width: 75%;
  margin-top: 6px;
}

/* Clear floats after the columns */
.row:after {
  content: "";
  display: table;
  clear: both;
}

/* Responsive layout - when the screen is less than 600px wide, make the two columns stack on top of each other instead of next to each other */
@media screen and (max-width: 600px) {
  .col-25, .col-75, input[type=submit] {
    width: 100%;
    margin-top: 0;
  }
}
</style>
</head>
<body>

<h1>Edit a monitored server</h1>

<div class="container">
  <form action='/send' method='post'>
  <div class="row">
    <div class="col-25">
      <label for="ip">IP</label>
    </div>
    <div class="col-75">
      <input type="text" id="ip" name="ip" value="$($Server.Server_Name)">
    </div>
  </div>
  <div class="row">
    <div class="col-25">
      <label for="name">Name</label>
    </div>
    <div class="col-75">
      <input type="text" id="name" name="name" value="$($Server.Server_Name)">
    </div>
  </div>
  <div class="row">
    <div class="col-25">
    </div>
  </div>
  <div class="row">

  </div>
  <br>
  <div class="row">
    <input type="submit" value="Submit">
  </div>
  </form>
</div>

</body>
</html>
"@

### List servers in html

$content = @"
<!DOCTYPE html>
<html>
<head>
<style>
#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: #0066ff;
  color: white;
}
</style>
</head>
<body>
"@

$htmltable = @"
</table>

  </div>
  <form action='/Remove=$ServerID' method='post'>
  <br>
  <div class="row">
  <input type="submit" value="Remove server">
  </form>      
  </div>

</body>
</html>
"@

# Create HTML
Remove-Item -Path ".\editServer.html" -Force -ErrorAction SilentlyContinue
New-Item -Path ".\editServer.html" -ItemType File -Value $form -Force
Add-Content -Path ".\editServer.html" -Value $content -Force


Add-Content -Value $htmltable -LiteralPath .\editServer.html -Force
}

#    <form action='/clear' id="ClearServers" method='post'>
#    <input type='reset' and add onclick='document.forms["ClearServers"].submit();'>