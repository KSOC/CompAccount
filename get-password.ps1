function get-password {
   <#
       .Description
        adds pass complexity

       .Example
        get-password 'word'
        get-password
   #>
	param (
		[string]
		$word
	)
	
	Begin {
	}
	Process {
		
		if ($word.length -lt $passwordvariables.MinChar.Length) {
			
			$word = $word.substring(0, $passwordvariables.Complexity.Capital).toupper() + $word.substring($passwordvariables.Complexity.Capital).tolower()
			
			$wordlength = $passwordvariables.MinChar.Length - $word.Length
			
			if ($wordLength -eq "1") {
				$number = Get-Random -Minimum 0 -Maximum 9
			}
			elseif ($wordLength -eq "2") {
				$number = Get-Random -Minimum 10 -Maximum 99
			}
			elseif ($wordLength -eq "3") {
				$number = Get-Random -Minimum 100 -Maximum 999
			}
			elseif ($wordLength -eq "4") {
				$number = Get-Random -Minimum 1000 -Maximum 9999
			}
			elseif ($wordLength -eq "5") {
				$number = Get-Random -Minimum 10000 -Maximum 99999
			}
			elseif ($wordLength -eq "6") {
				$number = Get-Random -Minimum 100000 -Maximum 999999
			}
			elseif ($wordLength -eq "7") {
				$number = Get-Random -Minimum 1000000 -Maximum 9999999
			}
			
			$password = $word + $number
			
		}
		else {
			
			$word1 = $word.substring(0, $passwordvariables.Complexity.Capital).toupper() + $word.substring($passwordvariables.Complexity.Capital).tolower()
			
			$leet = @{
				a   = '@'; e = 3; i = '!'; l = 1; o = 0
			}
			$rand = new-object System.Random
			$number = $null
			
			if ($args[0]) {
				$word = $args[0]
			}
			$leet.Keys | foreach-object {
				$skip = $rand.Next(0, 3); if ($skip -ne 0) {
					$word = $word.Replace($_, $leet[$_])
				}
			}
			
			$word2 = $word1.Substring(0, $passwordvariables.Word.Min_NonChanged_Char)
			$lastword = $word.Substring($passwordvariables.Word.Min_NonChanged_Char, $word.length - $passwordvariables.Word.Min_NonChanged_Char)
			$word3 = $word2 + $lastword
			
			if ($word3 -match "[0-9]") {
				$password = $word3
			}
			else {
				$number = Get-Random -Minimum 0 -Maximum 9
				$password = $word3 + $number
			}
			
		}
		
		
	}
	End {
		$password = $password + $special_character
		Write-Output $password
	}
}