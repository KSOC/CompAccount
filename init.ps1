
# use this file to define global variables on module scope
# or perform other initialization procedures.
# this file will not be touched when new functions are exported to
# this module.

	$lib = "\\kiewitplaza\ktg\Active\kss\KSS_Toolkit\KSS MultiTool\lib"
	$dictionary = "$lib\randomwords.txt"
	$UncommonWords = Get-Content "$lib\randomwords.txt"
	$special_characters = @('!', '@', '$', '#', '%', '&')
	$special_character = get-random $special_characters
