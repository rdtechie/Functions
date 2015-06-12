#requires -Version 2 -Modules SSH-Sessions
function Connect-SSHEndpoint 
{
    <#
            .SYNOPSIS
            Connect to SSH endpoints.

            .DESCRIPTION
            This function uses the SSH-Sessions module to connect via SSH to a SSH endpoint.

            .PARAMETER Node
            IP Address or Hostname of the SSH endpoint

            .PARAMETER Credential
            A PSCredential object as defined with Get-Credential.

            .INPUTS
            None

            .OUTPUTS
            None

            .EXAMPLE
            Connect to a SSH endpoint with PSCredential

            Defining PSCredential Object first:
            $credentials = Get-Credential

            Then we can connect with the function:
            Connect-Enclosure -Node 'ssh-enpoint-01.domain.local' -Credential $credentials -Verbose

            .EXAMPLE
            Connect to a SSH endpoint with a Keyfile and a username

            Defining PSCredential Object first:
            $credentials = Get-Credential

            Then we can connect with the function:
            Connect-Enclosure -Node 'ssh-enpoint-01.domain.local' -KeyFile 'D:\Data\keyfile' -Username 'admin' -Verbose

            .LINK
            http://www.powershelladmin.com/wiki/SSH_from_PowerShell_using_the_SSH.NET_library#Downloads

            .NOTES
            Version: 1.0
            Prerequisites: SSH-Sessions - http://www.powershelladmin.com/wiki/SSH_from_PowerShell_using_the_SSH.NET_library#Downloads
            Author: Richard Diphoorn
            Creation Date: 2015-06-03
            Purpose/Change: Initial Release
    #>
   
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    Param(
        [Parameter(
                ParameterSetName = 'Default',
                Mandatory = $true
        )]
        [ValidateNotNullorEmpty()]
        [Parameter(
                ParameterSetName = 'Key'
        )]
        [string]
        $Node,
        
        [Parameter(
                ParameterSetName = 'Default'
        )]
        [ValidateNotNullorEmpty()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.CredentialAttribute()]
        $Credential,
        
        [Parameter(
                ParameterSetName = 'Key'
        )]
        [ValidateNotNullorEmpty()]
        [string]
        $KeyFile,
        
        [Parameter(
                ParameterSetName = 'Key'
        )]
        [ValidateNotNullorEmpty()]
        [string]
        $Username
        
    )
    
    If (!(Get-Module -Name 'SSH-Sessions'))
    {
        Import-Module -Name SSH-Sessions
    }
   
    Try 
    {
        $null = New-SshSession -ComputerName $Node -Username $Credential.UserName -Password $Credential.GetNetworkCredential().password 
    }

    Catch 
    {
        Write-Warning -Message $_.Exception.Message 
    }

    Finally 
    {
        Write-Verbose -Message "Connected through SSH to Enclosure $Node" 
    }
}
