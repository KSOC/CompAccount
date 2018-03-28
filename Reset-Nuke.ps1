function Reset-Nuke($upn, $mspass) {
	try {
		# get user object from AD
		$user = Get-ADUser -Filter {
			UserPrincipalName -eq $upn
		} -SearchBase "DC=KIEWITPLAZA,DC=com"
		
		# connect to exchange online
		Write-Host "`t[+] connecting to Exchange online..." -ForegroundColor Yellow
		Connect-EXOPSSession -Credential $mspass | Out-Null
		Write-Host "`t[+] ...OK" -ForegroundColor Green
		
		# disable all client access services
		Write-Host "`t[+] enabling protocols on Exchange mailbox..." -ForegroundColor Yellow
		Set-CASMailbox $user.UserPrincipalName -MAPIEnabled $true -ActiveSyncEnabled $true -OWAEnabled $true -PopEnabled $true -ImapEnabled $true -Confirm:$false -WarningAction $WarningPreference
		Write-Host "`t[+] ...DONE" -ForegroundColor Green
		
		# connect to MSOnline
		Write-Host "`t[+] connecting to MSOnline..." -ForegroundColor Yellow
		Connect-MsolService -Credential $mspass | Out-Null
		Write-Host "`t[+] ...OK" -ForegroundColor Green
		
		# block credentials in MSOnline
		Write-Host "`t[+] unblocking credentials in MSOnline..." -ForegroundColor Yellow
		Set-MsolUser -UserPrincipalName $upn -BlockCredential $false
		Write-Host "`t[+] ...DONE" -ForegroundColor Green
		
		# connect to Azure AD
		Write-Host "`t[+] connecting to Azure AD..." -ForegroundColor Yellow
		Connect-AzureAD -Credential $mspass | Out-Null
		Write-Host "`t[+] ...OK" -ForegroundColor Green
		
		# get the AzureAD user object
		$azure_user = Get-AzureADUser -SearchString $user.UserPrincipalName
		
		# enable user in Azure AD
		Write-Host "`t[+] enabling user in Azure AD..." -ForegroundColor Yellow
		Set-AzureADUser -ObjectID $upn -AccountEnabled $true
		Write-Host "`t[+] ...DONE" -ForegroundColor Green
	}
	catch {
		# catch any errors and output the error record
		$error_record = $error[0].Exception.ErrorRecord
		Write-Host "[!] ERROR in fixNuke(): $error_record" -ForegroundColor Red
	}
}