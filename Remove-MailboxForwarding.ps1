Function Remove-MailboxForwarding {
	Param (
		[string]
		$UPN
	)
	Write-Host "Removing Mailbox Forwarding on [$UPN]..."
	Set-Mailbox -Identity $upn -DeliverToMailboxAndForward $false -ForwardingSmtpAddress $null -ForwardingAddress $null -force
}