function reset-pass ($upn) {
	Get-ADUser -Filter "UserPrincipalName -eq '$upn'" | Set-ADAccountPassword -Credential $ADpass -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "Welcome2Kiewit18" -Force)
}