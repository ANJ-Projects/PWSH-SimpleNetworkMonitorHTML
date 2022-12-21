# Implementing PWSH SNM v2
*Better editing, check in pings, dedicated database and other features*  
View [changes](#changes)

## Given a new name (TBA)
Another simpler name will be used

## Sqlite based
This will be using sqlite. Sqlite will be better fitted since creating, removing or changing rows will be easier compared to using .csv files


## Script monitoring features
Objectives summary

- web at /edit needs support editing single rows and changed to edit-servers
- edit-monitors will be added, these will support webrequest and reset on a timer, if too much time goes without a ping the row will be marked as down

### Changes to edit

A new field will be added to the row which has an "edit" buttom, that buttom will take the user to a new site where values can be changed or updated

/edit-[Servername]
Will create a new HTML page for editing the server using Add-EditHTMLServer -ServerID [ServerID]

### New ping check ins feature
*Will query database, if not found request within specified minutes it will mark the ping as down*

Example
```pwsh
Invoke-Webrequest -Uri "localhost:8082/checkin-CHECKINNAME"
```
Explaning the check in method

*This will update the row with a new timestamp, a "checker" schedule will check the "minutes to mark as down" with the timestamp since last request and mark the point as down if it has not checked in within the timeframe set*

# API (Webhook)
*A list with POST will be added, showng various examles*

# Optional tasks

- Create a docker container for the project
- Create a Ansible playbook for install on a fresh Ubuntu Serer
- Documentate how to create a Windows Service and Linux Systemctl service

# Changes
13. december 2022 21:00:11  
- New Create-Sqlite3db script made
   - DB soon ready for changes to edit-servers
14. december 2022 15:05:38
- Add-EditHTML has been changed to use sqlite and new html tables have been made
   - In the table there is now a link for editing the Server
15. december 2022 14:53:38
 - Add-EditHTMLServer updates
   - Now supports parameter ServerID
      - This can be used for the EditHTML "Edit" table
      - /Remove-$ServerID is now a buttom, needs to connect with a remove server sql statement
   - Now using "value" instead off "placeholder" the text will be editable