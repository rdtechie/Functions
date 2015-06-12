#requires -Version 1
Function Get-ComputerDetails
{
    [cmdletbinding()]
    Param([string[]]$Computer)
    
    $result = @()

    foreach ($node in $Computer)
    {
        try
        {
            [pscustomobject][ordered]@{
                Name         = (Get-WmiObject -Class Win32_ComputerSystem -ComputerName $node -ErrorAction Stop).Name
                Manufacturer = (Get-WmiObject -Class Win32_ComputerSystem -ComputerName $node -ErrorAction Stop).Manufacturer
                Model        = (Get-WmiObject -Class Win32_ComputerSystem -ComputerName $node -ErrorAction Stop).Model
                Serial       = (Get-WmiObject -Class Win32_Bios -ComputerName $node -ErrorAction Stop).SerialNumber
            }
        }
        catch 
        {
            Write-Error -Message "The command failed for computer $node. Message: $_.Exception.Message"
            break
        }
    }
}
