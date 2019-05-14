Function New-ConEmuTab {
    <#
    .SYNOPSIS
        Spawns a new powershell window in Conemu. Will eventually change this to allow other prompts.
    .DESCRIPTION
        Utilizes Conemu's command switch to open up console tabs. Next extensiblity option - percentages!
    #>
    [CmdletBinding()]
	param(

        # splits window to bottom -exclusive, will not work with Horizontal
        [Parameter(
            ParameterSetName='Vertical'
        )]
        [switch]$Vertical,

        [Parameter(
            ParameterSetName='Horizontal'
        )]
        # splits window to side -exclusive, will not work with vertical
        [switch]$Horizontal,

        # Launches new process as Administrator (on accounts with no local admin, requests credentials)
        [switch]$Admin,

        # I can't remember what this does :(
        [int]$Size

    )
	$ConPrefix = "-cur_console"
	$Split = ""
	$AdminSuffix = ""
	if ($Vertical){
		$Split = ":s"+$size+"V"
    }
	if ($Horizontal){
		$Split = ":s"+$size+"H"
    }
	if ($Admin){
		$AdminSuffix = ":a"
    }
	$Output = $ConPrefix + $AdminSuffix + $Split
	ConEmu64.exe -reuse /cmd powershell $Output
}