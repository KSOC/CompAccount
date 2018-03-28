function Get-MailboxForwarding ($upn) {
   <#
       .Description
        check current fwd smtp settings

       .Example
        Work-InboxRules -upn 'first.last@domain.com'
   #>	
	Get-Mailbox $upn | Select-Object ForwardingSmtpAddress, ForwardingAddress
}