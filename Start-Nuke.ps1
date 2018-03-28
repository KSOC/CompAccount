function Start-Nuke ($upn) {
   <#
       .Description
        Nukes user account to no access, revokes all active sessions and burns all session tokens 

       .Example
       "MSPass
        Run-Nuke -UPN 'first.last@domain.com'"
   #>
  try {
    # get user object from AD
    $user = Get-ADUser -Filter {
      UserPrincipalName -eq $upn
    } -SearchBase "DC=KIEWITPLAZA,DC=com"
		
    # connect to exchange online
    Write-Host "`t[+] connecting to Exchange online..." -ForegroundColor Yellow
    Connect-EXOPSSession -Credential $mspass | Out-Null
		
    # disable all client access services
    Write-Host "`t[+] disabling protocols on Exchange mailbox..." -ForegroundColor Yellow
    Set-CASMailbox $user.UserPrincipalName -MAPIEnabled $false -ActiveSyncEnabled $false -OWAEnabled $false -PopEnabled $false -ImapEnabled $false -Confirm:$false -WarningAction $WarningPreference
		
    # connect to MSOnline
    Write-Host "`t[+] connecting to MSOnline..." -ForegroundColor Yellow
    Connect-MsolService -Credential $mspass | Out-Null
		
    # block credentials in MSOnline
    Write-Host "`t[+] blocking credentials in MSOnline..." -ForegroundColor Yellow
    Set-MsolUser -UserPrincipalName $upn -BlockCredential $true
		
    # connect to sharepoint online
    Write-Host "`t[+] connecting to SharePoint online..." -ForegroundColor Yellow
    Connect-SPOService -url "https://o365spo-admin.kiewit.com/" -Credential $mspass | Out-Null
		
    # kills all active sharepoint sessions
    Write-Host "`t[+] revoking all sessions to SharePoint online..." -ForegroundColor Yellow
    $result = Revoke-SPOUserSession -User $user.UserPrincipalName -Confirm:$false | Out-Null
    Write-Host "`t[+] ...DONE`n$result" -ForegroundColor Green
		
    # connect to Azure AD
    Write-Host "`t[+] connecting to Azure AD..." -ForegroundColor Yellow
    Connect-AzureAD -Credential $mspass | Out-Null
		
    # get the AzureAD user object
    $azure_user = Get-AzureADUser -SearchString $user.UserPrincipalName
		
    # revoke all current/active refresh tokens from Azure AD
    Write-Host "`t[+] invalidating the refresh tokens issued to applications for $($user.UserPrincipalName)..." -ForegroundColor Yellow
    Revoke-AzureADUserAllRefreshToken -ObjectId $azure_user.ObjectId
		
    # disable user in Azure AD
    Write-Host "`t[+] disabling user in Azure AD..." -ForegroundColor Yellow
    Set-AzureADUser -ObjectID $upn -AccountEnabled $false
		
    #reset user pass
    Write-Host "`t[+] Resetting user pass AD..." -ForegroundColor Yellow
    reset-pass -upn $upn
		
    Start-Countdown -Seconds 120
		
    Write-Host "`t[+] checking user pass AD..." -ForegroundColor Yellow
    net user $upn /domain | findstr "Password"
  }
  catch {
    # catch any errors and output the error record
    $error_record = $error[0].Exception.ErrorRecord
    Write-Host "[!] ERROR in runNuke(): $error_record" -ForegroundColor Red
  }
}