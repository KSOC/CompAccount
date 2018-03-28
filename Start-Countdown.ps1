Function Start-Countdown {
   <#
       .Description
        Countdown timer in Seconds

       .Example
        Start-Countdown -Seconds (60*3)
        Start-Countdown -Seconds 60 -Message "Technical Difficulties, Please Stand by..."
   #>
	[CmdletBinding()]
	Param (
		[Parameter(Mandatory = $True)][int]
		$Seconds,
		[string]
		$Message = "Stand by for $Seconds seconds..."
	)
	For ($i = 1; $i -le $seconds; $i++) {
		Write-Progress -Id 1 -Activity $Message -Status "Stand by for $Seconds seconds, $($Seconds - $i) left" -PercentComplete (($i / $Seconds) * 100)
		Start-Sleep -Seconds 1
	}
	Write-Progress -Id 1 -Activity $Message -Status "Completed" -PercentComplete 100 -Completed
}