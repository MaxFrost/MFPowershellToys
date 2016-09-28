<#
.SYNOPSIS
Spawns a new powershell window in Conemu. Will eventually change this to allow other prompts.
.PARAMETER Vertical
splits window to bottom -exclusive, will not work with Horizontal
.PARAMETER Horizontal
splits window to side -exclusive, will not work with vertical
.PARAMETER Admin
launches new process as Administrator (on accounts with no local admin, requests credentials)
.DESCRIPTION
Utilizes Conemu's command switch to open up console tabs. Next extensiblity option - percentages!
#>
Function new-conemu()
{
	param(
		[switch]$Vertical,
		[switch]$Horizontal,
		[switch]$Admin,
		$Size
	)
	$conprefix = "-cur_console"
	$split = ""
	$asuffix = ""
	if ($Vertical){
		$split = ":s"+$size+"V"
		}
	if ($Horizontal){
		$split = ":s"+$size+"H"
		}
	if ($Admin){
		$asuffix = ":a"
		}
	$output = $conprefix + $asuffix + $split
	ConEmu64.exe -reuse /cmd powershell $output
}