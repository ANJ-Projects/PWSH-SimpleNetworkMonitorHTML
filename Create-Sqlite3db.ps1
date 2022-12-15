

# Check if db is created
if (test-path -Path ".\monitor.db3") {
    "DB Found"
} 
else 
{
    "DB not found. Creating db..."

# This will create a sqldb
$sqlite3 = 'sqlite3.exe'
$databaseName = '.\monitor.db3'

# Create a db
Invoke-Expression -Command "$sqlite3 $databaseName '.databases'" 
# Invoke-Expression -Command ".exit"

# Create table for CheckIns
$query = @"
'CREATE TABLE "CheckIns" (
	"CheckIn_Name"	TEXT,
	"LastCheckIn_Stamp"	TEXT,
	"Status"	TEXT,
	"Notes"	TEXT
, "CheckIn_Interval"	INTEGER
);'
"@

Invoke-Expression -Command "$sqlite3 $databaseName $query"

# Create table for Servers
$query = @"
'CREATE TABLE "Servers" (
	"ServerID"	INTEGER,
	"Server_Name"	TEXT,
	"Notes"	TEXT,
	"Status"	TEXT,
	"LastCheckIn_Stamp"	TEXT,
	PRIMARY KEY("ServerID")
);'
"@ 

# Changes made, use this if erros
<# $query = @"
'CREATE TABLE "Servers" (
	"Server_Name"	TEXT,
	"LastCheckIn_Stamp"	TEXT,
	"Status"	TEXT,
	"Notes"	TEXT
);'
"@ #>

Invoke-Expression -Command "$sqlite3 $databaseName $query"

# PUT in test data
$query = @"
INSERT INTO Servers (Server_Name,Notes,Status,LastCheckIn_Stamp)
VALUES ('N230', '', 'UP', '13. december 2022 20:36:20');
"@

Invoke-Expression -Command @"
$sqlite3 $databaseName "$query"
"@

# PUT in test data
$query = @"
INSERT INTO Servers (Server_Name,Notes,Status,LastCheckIn_Stamp)
VALUES ('RASP-Octan', '', 'UP', '14. december 2022 20:36:20');
"@

Invoke-Expression -Command @"
$sqlite3 $databaseName "$query"
"@

# List tables
Invoke-Expression -Command 'sqlite3.exe .\monitor.db3 .tables'

# Grab table named servers
Invoke-Expression -Command 'sqlite3.exe .\monitor.db3 -header "Select * from Servers" | ConvertFrom-Csv -Delimiter "|"'
# Grab table named CheckIns
Invoke-Expression -Command 'sqlite3.exe .\monitor.db3 -header "Select * from CheckIns" | ConvertFrom-Csv -Delimiter "|"'

}