Function Set-Audit {
	Param (
		[string]
		$UPN
	)
	Write-Host "[$UPN] Enabling Auditing.."
	Set-Mailbox -Identity $UPN -AuditEnabled:$true -AuditLogAgeLimit 365 -WarningAction:SilentlyContinue
}