function Confirm-InboundProvisioningConnection {
    [CmdletBinding()]

    param (
        # [Parameter(Mandatory = $false)]
        # [string[]] $Scopes = "Application.ReadWrite.All"
    )

    Process {
        $ConnectString = "Connect-MgGraph -scope Application.ReadWrite.All, Synchronization.ReadWrite.All"
        $_C = Get-MgContext
        if(!$_C) {
            throw "Please connect using the following cmdlet: $ConnectString"
        }

        if($_C.Scopes -notcontains "Application.ReadWrite.All") {
            Write-Warning "The current token does not have the required scope 'Application.ReadWrite.All', please connect using $ConnectString"
        }

        if($_C.Scopes -notcontains "Synchronization.ReadWrite.All") {
            Write-Warning "The current token does not have the required scope 'Synchronization.ReadWrite.All', please connect using $ConnectString"
        }
    }
}