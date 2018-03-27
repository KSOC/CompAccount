Function ADPass {
   <#
       .Description
       Secure credential store for .admin account

       .Example
        ADPass
        Connect-MSOLservice -Credential $ADPass
   #>
	if ($adpass -eq $null) {
		$Script:ADPass = Get-Credential -Message "Enter .Admin account and password to connect to AD"
	}
}