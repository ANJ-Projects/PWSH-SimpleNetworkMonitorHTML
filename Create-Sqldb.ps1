

# This will create a sqldb
$sqlite3 = 'sqlite3.exe'
$databaseName = '.\monitor.db3'

# Create a db
Invoke-Expression -Command "$sqlite3 $databaseName"
Invoke-Expression -Command ".quit"

# Create table for CheckIns
$query = @"
'CREATE TABLE "CheckIns" (
	"CheckIn_Name"	TEXT,
	"LastCheckIn_Stamp"	TEXT,
	"Status"	TEXT,
	"Notes"	TEXT
, "CheckIn_Interval"	INTEGER)
);'
"@

Invoke-Expression -Command "$sqlite3 $databaseName $query"

# Create table for Servers
$query = @"
'CREATE TABLE "Servers" (
	"Server_Name"	TEXT,
	"LastCheckIn_Stamp"	TEXT,
	"Status"	TEXT,
	"Notes"	TEXT
);'
"@

# Grab table named servers
sqlite3.exe .\monitor.db3 -header "Select * from Servers" | ConvertFrom-Csv -Delimiter "|"
# Grab table named CheckIns
sqlite3.exe .\monitor.db3 -header "Select * from CheckIns" | ConvertFrom-Csv -Delimiter "|"

# List tables
sqlite3.exe .\monitor.db3 .tables

<#
CREATE TABLE "Servers" (
	"Server_Name"	TEXT,
	"LastCheckIn_Stamp"	TEXT,
	"Status"	TEXT,
	"Notes"	TEXT
);

CREATE TABLE "CheckIns" (
	"CheckIn_Name"	TEXT,
	"LastCheckIn_Stamp"	TEXT,
	"Status"	TEXT,
	"Notes"	TEXT
, "CheckIn_Interval"	INTEGER)
);
#>
<#
$query = @"
"CREATE TABLE "checkins" (
	"checkin_name" VARCHAR(255) NULL,
	"lastcheckin_stamp" VARCHAR(255) NULL,
	"Status" VARCHAR(255) NULL
)
;
"@
#>

#$query = @"
#"CREATE TABLE "checkins" ("checkin_name" VARCHAR(255) NULL,"lastcheckin_stamp" VARCHAR(255) NULL,"Status" VARCHAR(255) NULL);
#"@