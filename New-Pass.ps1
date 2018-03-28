Function New-Pass {
   <#
       .Description
        generates strong password

       .Example
        Generate-Pass
   #>	

	$lib = "\\kiewitplaza\ktg\Active\kss\KSS_Toolkit\KSS MultiTool\lib"
	$dictionary = "$lib\randomwords.txt"
	$UncommonWords = Get-Content "$lib\randomwords.txt"
	$special_characters = @('!', '@', '$', '#', '%', '&')
	$special_character = get-random $special_characters
	$random1 = Get-Content $dictionary | Get-Random
	$newphrase = get-password $random1
	write-host $NewPhrase
	$Script:NewPhrase = $NewPhrase
}