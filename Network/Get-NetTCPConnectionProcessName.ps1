#requires -Version 3 -Modules NetTCPIP
function Get-NetTCPConnectionProcessName
{
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $false,Position = 0)]
        $Value = 'Established'
    
    )

    Get-NetTCPConnection |
    Where-Object -Property State -EQ -Value $Value | ForEach-Object -Process {
        [PSCustomObject] @{
            'ProcessName' = (Get-Process -Id $_.OwningProcess).Name
            'ProcessId' = (Get-Process -Id $_.OwningProcess).Id
            'RemoteIP'  = $_.RemoteAddress
            'LocalPort' = $_.LocalPort
            'State'     = $_.State
        }
    }
}

