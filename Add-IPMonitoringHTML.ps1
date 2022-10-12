

$PSDefaultParameterValues['*:Encoding'] = 'utf8'

Remove-Item -Path ".\index.html" -ErrorAction SilentlyContinue

Function Add-IPMonitoringHTML {

# Removes the file
# Remove-Item -Path ".\index.html" -Force # -ErrorAction SilentlyContinue

# This creates the website in the current folder
New-PHDashboard -TabTitle 'Simple Network Monitoring' -Title 'Simple Network Monitoring' -MiniTitle 'Used for monitoring servers' -BodyTitle 'Server Status' -CenterBodyTitle Yes

If (Test-Path -Path ".\servers.txt") {
$serverlist = Get-content ".\servers.txt" | ConvertFrom-Csv -Delimiter ','
}
Else
{ 
Write-Host 'Server text file named servers.txt not found. Creating file... -f Red'
New-Item -ItemType File -Path ".\servers.txt" -Value "ip,name`r`n"
}

$date = Get-Date
Add-Content -Value "<p> Last updated $date </p>" -LiteralPath .\index.html -Force

foreach ($server in $serverlist){
  if (Test-Connection -ComputerName $server.ip -Count 1 -Quiet){
    Write-Host "$server,up"
    Add-Content -Value "<p style=`"color:green;`">$($server.name) with IP $($server.ip) is up</p>" -LiteralPath .\index.html -Force
  }
  else{
    Write-Host "$server,down"
    Add-Content -Value "<p style=`"color:red;`">$($server.name) with IP $($server.ip) is down</p>" -LiteralPath .\index.html -Force
  }
}

}
