Function Request-Forensics {
	Param (
		[string]
		$UPN,
		[string]
		$MailboxIdentity
	)
	
	$ForensicsFolder = "$PSScriptRoot\Forensics\$UPN\"
	
	Write-Host "[$UPN] Dumping forensics to $ForensicsFolder"
	if (!(Test-Path($ForensicsFolder))) {
		Try {
			mkdir $ForensicsFolder -ErrorAction:Stop | Out-Null
		}
		catch {
			Write-Error "Cannot create directory $ForensicsFolder"
			exit
		}
	}
	
	Get-Mailbox -Identity $UPN | Export-CliXml "$ForensicsFolder\$UPN-mailbox.xml" -Force | Out-Null
	Get-InboxRule -Mailbox $UPN | Export-CliXml "$ForensicsFolder\$UPN-inboxrules.xml" -Force | Out-Null
	Get-MailboxCalendarFolder -Identity "$($MailboxIdentity):\Calendar" | Export-CliXml "$ForensicsFolder\$UPN-MailboxCalendarFolder.xml" -Force | Out-Null
	Get-MailboxPermission -Identity $upn | Where-Object {
		($_.IsInherited -ne "True") -and ($_.User -notlike "*SELF*")
	} | Export-CliXml "$ForensicsFolder\$UPN-MailboxDelegates.xml" -Force | Out-Null
	Get-MobileDevice -Mailbox $upn | Export-CliXml "$ForensicsFolder\$UPN-devices.xml" -Force | Out-Null
	Get-MobileDevice -Mailbox $upn | Get-MobileDeviceStatistics | Export-CliXml "$ForensicsFolder\$UPN-devicestatistics.xml" -Force | Out-Null
	
	# Audit log if it exists
	
	$startDate = (Get-Date).AddDays(-7).ToString('MM/dd/yyyy')
	$endDate = (Get-Date).ToString('MM/dd/yyyy')
	
	Search-UnifiedAuditLog -StartDate $startDate -EndDate $endDate -UserIds $upn | Export-Csv -Path "$ForensicsFolder\$UPN-AuditLog.csv" -NoTypeInformation
	
}