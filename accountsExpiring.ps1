param($numberofdays = 14, $path = [Environment]::GetFolderPath("Desktop")+'\'+'ExpiringBetween-'+(Get-Date -format M-d-yyyy)+'and'+(get-date).AddDays(14).ToString("M-d-yyyy")+'.csv')
$numberofdays = $numberofdays | Out-String
$($expiringUsers = Search-ADAccount -AccountExpiring -TimeSpan $numberofdays

$modName = 'ActiveDirectory'
If (-not(Get-Module -name $modName)) { 
	If (Get-Module -ListAvailable | Where-Object { $_.name -eq $modName }) { 
		Import-Module -Name $modName 
		Write-Host "Loaded " $modName " module."
		}
	else {
		Write-Host $modName " module not available. Unable to continue." 
		}
	}

Foreach ($item in $expiringUsers){	
	
	$item = Get-ADUser $item -Properties GivenName, Surname, manager, 
										 AccountExpirationDate, enabled, Department, Division, title, samaccountname, mail, telephoneNumber, employeeID
					
	Add-Member -input $item NoteProperty 'Manager Name' 'None' -Force
	Add-Member -input $item NoteProperty 'Manager E-mail' 'None' -Force
	Add-Member -input $item NoteProperty 'Employee Name' 'None' -Force
	
	$item.'Employee Name' = $item.GivenName + ' ' + $item.Surname
	
	if ($item.Manager){
	
	$item.'Manager Name' = (Get-ADUser -Identity $item.manager -Properties GivenName).GivenName + ' ' + (Get-ADUser -Identity $item.manager -Properties Surname).Surname
	$item.'Manager E-Mail' = (Get-ADUser -Identity $item.manager -Properties mail).Mail
	}

	$item | select 'Employee Name', 'Manager Name', 'Manager E-mail', AccountExpirationDate, enabled, 
					Department, Division, title, samaccountname, mail, telephoneNumber, employeeID
					
}) | Export-Csv $path -NoTypeInformation

If (Test-Path $path) { Write-Host -NoNewline `n"Export of all AD accounts expiring in " $numberofdays " days have been exported to the following file:" `n `n $path `n `n}