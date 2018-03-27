Function MSPAss {
   <#
       .Description
       Secure credential store for cloud admin account

       .Example
        MSPass
        Connect-MSOLservice -Credential $MSPass
   #>
	if ($mspass -eq $null) {
		$Script:MSPass = Get-Credential -Message "Enter cloud admin username and password to continue"
	}
}