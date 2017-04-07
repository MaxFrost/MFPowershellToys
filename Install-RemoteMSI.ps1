Param(
    [cmdletbinding()]
    [Parameter(
        Mandatory=$true,
        Position=0,
        ValueFromPipeline=$true,
        ValueFromPipelineByPropertyName=$true
        )
    ]
    [Alias('ComputerName')]
    [string[]]$Name,
    [Parameter(
        Mandatory=$true,
        Position=1
        )
    ]
    [string]$InstallerPath
)

$InstallFilePath = (get-childitem $InstallerPath).directoryName
$InstallFile = (get-childitem $InstallerPath).name
foreach ($computer in $Name){
    Write-Output "Installing: $InstallFilePath\$installFile to $Computer"
    if(test-wsman $Computer -ErrorAction Ignore){
        Write-Verbose "Begin Copy Block"
        Write-Verbose "Begin $InstallFile copy"
        if (-not (test-path "\\$($Computer)\c$\Windows\Patches\" )){
            new-item "\\$($Computer)\c$\Windows\Patches\" -ItemType Directory
        }
        copy-item "$InstallFilePath\$InstallFile" "\\$($Computer)\c$\Windows\Patches\" -Force
        Write-Verbose "$InstallFile copied"
        Write-Verbose "End Copy Block"
        Write-Verbose "Being Invoke-Command Block"
        Write-Verbose "Target PC = $Computer"
        invoke-command -computerName $Computer -ScriptBlock {
            Start-Process C:\Windows\System32\msiexec.exe -ArgumentList /i, "C:\Windows\Patches\$($args[0])", /qn, /norestart -wait
            get-eventlog -LogName application -newest 1 -InstanceId 1033 | select-object message
        } -ArgumentList (,$InstallFile)
        Write-Verbose "Invoke-Command Block completed"
        Write-Output "Deployment Complete"
        Remove-Item "\\$Computer\c$\Windows\Patches\$InstallFile"
    }else{
        write-warning -Message "unable to connect to WinRM @ $($computer)"
    }
}
