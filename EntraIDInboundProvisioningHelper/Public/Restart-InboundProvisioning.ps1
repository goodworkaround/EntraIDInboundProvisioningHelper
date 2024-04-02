<#
.DESCRIPTION
Perform a deep restart of inbound provisioning job
#>
function Restart-InboundProvisioning {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $ObjectId
    )

    process {
        Confirm-InboundProvisioningConnection
        
        $ServicePrincipal = Get-InboundProvisioningServicePrincipal -ObjectId $ObjectId

        $Job = Get-MgServicePrincipalSynchronizationJob -ServicePrincipalId $ServicePrincipal.Id
        
        $body = @{
            criteria = @{
                resetScope = "Full"
            }
        }
        $url = "https://graph.microsoft.com/v1.0/servicePrincipals/{0}/synchronization/jobs/{1}/restart" -f $ServicePrincipal.Id, $Job.Id

        Write-Verbose "Sending restart request to $url"
        Invoke-MgGraphRequest -Method POST -Uri $url -Body ($body | ConvertTo-Json -Depth 100)
    }
}