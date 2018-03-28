Function Unregister-ForwardingRules 
{
  Param (
    [string]
    $UPN
  )
  Write-Host "[$UPN] Disabling forwarding rules.."
  Get-InboxRule -Mailbox $UPN |
  Where-Object -FilterScript {
    (($_.Enabled -eq $true) -and (($_.ForwardTo -ne $null) -or ($_.ForwardAsAttachmentTo -ne $null) -or ($_.RedirectTo -ne $null) -or ($_.SendTextMessageNotificationTo -ne $null)))
  } |
  Disable-InboxRule -Confirm:$true
}
