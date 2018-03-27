Function Get-UserObject {
   <#
       .Description
       Validates upn against AD, captures as ad object

       .Example
        get-upn 'first.last@Kiewit.com'
        $UserObject.name
        $UserObject.mail
   #>
    [cmdletbinding()]
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({If ($_ -match '(^[_a-z-]+\.[_a-z0-9-]+@kiewit.com$)|(^[_a-z-]+\.[_a-z0-9-]+$)') {
            $True
        } Else {
            throw "$_ is not a valid UPN, Please enter a valid UPN"
        }})]
        [string[]]
        $Name
    )
    Process {
          $_ = get-aduser -Properties Mail -Filter "(UserPrincipalName -like $name) -or (name -like $name) or (Mail -like $name"
    }
    end {
    $script:UserObject = $_
    $UserObject
    }
}