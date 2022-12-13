# Implementing PWSH SNM v2
*Better editing, check in pings, dedicated database and other features*

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

### New ping check ins feature
*Will query database, if not found request within specified minutes it will mark the ping as down*

Example
```pwsh
Invoke-Webrequest -Uri "localhost:8082/checkin-CHECKINNAME"
```
Explaning the check in method

*This will update the row with a new timestamp, a "checker" schedule will check the "minutes to mark as down" with the timestamp since last request and mark the point as down if it has not checked in within the timeframe set*