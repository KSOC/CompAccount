function Unregister-InboxRule($rule_id) {
	try {
		# try to remove inbox rule from mailbox
		Write-Host "`t[+] removing inbox rule $rule_id..." -ForegroundColor Yellow
		Remove-InboxRule -Identity $rule_id -Confirm:$false
	}
	catch {
		# catch any errors and output the error record
		$error_record = $error[0].Exception.ErrorRecord
		Write-Host "[!] ERROR in deleteInboxRule(): $error_record" -ForegroundColor Red
	}
}