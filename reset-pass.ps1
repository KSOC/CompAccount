function Reset-Pass () {
   <#
       .Description
        Resets Users Pass 

       .Example
        Reset-Pass -UPN 'first.last@domain.com'
   #>
   Param ( 
    [Parameter(Mandatory = $True)]
    [string]
    $UPN
    )
  Get-ADUser -Filter "UserPrincipalName -eq '$upn'" | Set-ADAccountPassword -Credential $ADpass -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "Welcome2Kiewit18" -Force)
}

#############
##needs to generate-pass
###########