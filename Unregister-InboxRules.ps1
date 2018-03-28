function Unregister-InboxRules($upn) {
   <#
       .Description
        check and remove mailicous inbox rules

       .Example
        Work-InboxRules -upn 'first.last@domain.com'
   #>	
	try {
		$inbox_rules = Get-InboxRule -Mailbox $upn
		if ($inbox_rules) {
			$count = 1
			foreach ($rule in $inbox_rules) {
				$rule_id = $rule.Identity
				$rule_desc = $rule.Description
				if ($rule.DeleteMessage -OR $rule.RedirectTo -OR $rule.ForwardTo) {
					Write-Host "[Rule $count] [POTENTIALLY MALICIOUS] $rule_id" -BackgroundColor Black -ForegroundColor Magenta
					Write-Host "$rule_desc`n"
				}
				else {
					Write-Host "[Rule $count] $rule_id" -ForegroundColor Cyan
					Write-Host "$rule_desc`n"
				}
				$count++
			}
		}
		else {
			Write-Host "`t[+] no inbox rules found for $upn..." -BackgroundColor Black -ForegroundColor Green
		}
	}
	catch {
		$error_record = $error[0].Exception.ErrorRecord
		Write-Host "[!] ERROR in showInboxRules(): $error_record" -ForegroundColor Red
	}
  do {
    $rule_id = Read-Host "[?] Enter a rule identity (first.last/ruleID) to delete (or 'none' to stop)"
    if ($rule_id -ne 'none') {
      deleteInboxRule $rule_id
    }
  }
  while ($rule_id -ne 'none')
}