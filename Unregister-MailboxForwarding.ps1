Function Unregister-MailboxForwarding {
   <#
       .Description
        removes mbx fwds 

       .Example
        Remove-mailboxForwarding -UPN 'first.last'
   #>
  Param (
    [Parameter(Mandatory = $True)]
    [string]
    $UPN
  )
  Write-Host "Removing Mailbox Forwarding on [$UPN]..."
  Set-Mailbox -Identity $upn -DeliverToMailboxAndForward $false -ForwardingSmtpAddress $null -ForwardingAddress $null -force
}