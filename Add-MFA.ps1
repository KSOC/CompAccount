Function Add-MFA {
	
	# var used to validate if user has started mfa
	$list = "CN=MFAEnrollment,OU=Groups,OU=Kiewit,DC=KIEWITPLAZA,DC=com", "CN=MFA-Users,OU=Groups,OU=Kiewit,DC=KIEWITPLAZA,DC=com"
	$user = get-aduser $upn -Properties memberof
	$data = $null
	
	# loop to check if user needs a new ad group
	foreach ($group in $user.MemberOf) {
		if ($list -contains $group) {
			$data = 'has data'
			write-host $upn has $group -ForegroundColor Green -BackgroundColor Black
		}
	}
	#add user to mfa ad group if needed
	if (!$data) {
		Add-ADGroupMember -Identity mfaenrollment -Members $user.DistinguishedName -Credential $adpass -WhatIf
	}
}