Param(
    [Parameter(Mandatory=$true,Position=1)]
    [string]$TargetComputer,
    [string]$InstallerPath
)
$ComputerName = $targetComputer
$InstallFilePath = (get-childitem $InstallerPath).directoryName
$InstallFile = (get-childitem $InstallerPath).name

Write-Output "Installing: $InstallFilePath\$installFile to $ComputerName"
if(test-wsman $ComputerName -ErrorAction Ignore){
    Write-Verbose "Begin Copy Block"
    Write-Verbose "Begin $InstallFile copy"
    if (-not (test-path "\\$($ComputerName)\c$\Windows\Patches\" )){
        new-item "\\$($ComputerName)\c$\Windows\Patches\" -ItemType Directory
    }
    copy-item "$InstallFilePath\$InstallFile" "\\$($ComputerName)\c$\Windows\Patches\" -Force
    Write-Verbose "$InstallFile copied"
    Write-Verbose "End Copy Block"
    Write-Verbose "Being Invoke-Command Block"
    Write-Verbose "Target PC = $ComputerName"
    invoke-command -computerName $ComputerName -ScriptBlock {
        Start-Process C:\Windows\System32\msiexec.exe -ArgumentList /i, "C:\Windows\Patches\$($args[0])", /qn, /norestart -wait
        get-eventlog -LogName application -newest 1 -InstanceId 1033 | select-object message
    } -ArgumentList (,$InstallFile)
    Write-Verbose "Invoke-Command Block completed"
    Write-Output "Deployment Complete"
    Remove-Item "\\$ComputerName\c$\Windows\Patches\$InstallFile"
}else{
    write-warning -Message "unable to connect to WinRM"
    return
}