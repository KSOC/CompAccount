function Get-HiveData () {
   <#
       .Description
       Collects data in console to work Hive case

       .Example
        Get-HiveData $upn
        
   #>
	param (
		$upn
	)
	Write-Host "User Info" -ForegroundColor Red
	Get-ADUser $upn.name -Properties * | Select-Object UserPrincipalName, Title, Mobile, Ipphone, HomePhone, TelephoneNumber
	Write-Host "Manager Info" -ForegroundColor Red
	$manager = (Get-ADUser -Identity $upn.name -Properties *).manager
	Get-ADUser $manager -Properties * | Select-Object  Name, TelephoneNumber, Mobile, Ipphone, HomePhone
	net user $upn.name /domain | findstr "Password"
}