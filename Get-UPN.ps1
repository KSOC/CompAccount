Function Get-UPN {
   <#
       .Description
       Validates upn against AD

       .Example
        get-upn 'first.last'
        $UPN
        $UPN
   #>
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({If ($_ -match '[_a-z-]+(\.[_a-z0-9-]+)|[_a-z-]+(\.[_a-z0-9-]+)@(?i)kiewit.com') {
            $True
        } Else {
            throw 'Please enter a valid UPN'
        }})]
        [string[]]
        $Name
    )
    Process {
          $_ = get-aduser -Filter "(UserPrincipalName -like '$name') -or (name -like '$name')"
    }
    end {
    $script:UPN = $_.UserPrincipalName
    $UPN
    }
}