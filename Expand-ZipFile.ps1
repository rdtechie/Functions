#requires -Version 2
function Expand-ZipFile()
{
    [CmdletBinding()]
    Param(

        [Parameter(Mandatory = $true,Position = 0)][string]$SourcePath,
        [Parameter(Mandatory = $true,Position = 1)][string]$DestinationPath,
        [Parameter(Mandatory = $true,Position = 2)][bool]$Overwrite
    )

    Add-Type -AssemblyName System.IO.Compression.FileSystem

    try
    {
        foreach($sourcefile in (Get-ChildItem -Path $SourcePath -Filter '*.ZIP')) 
        {
            $entries = [IO.Compression.ZipFile]::OpenRead($sourcefile.FullName).Entries
        
            $entries | ForEach-Object -Process {
                [IO.Compression.ZipFileExtensions]::ExtractToFile($_,"$DestinationPath\$_",$Overwrite)
            }
        }
    }
        
    catch
    {
        Write-Warning -Message $_.Exception.Message
    }
}
