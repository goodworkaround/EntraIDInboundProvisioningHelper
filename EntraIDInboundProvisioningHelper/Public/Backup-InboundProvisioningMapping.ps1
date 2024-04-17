<#
.SYNOPSIS
Backs up the inbound provisioning mapping to a file. This can be restored to the same service principal or another service principal by using the Restore cmdlet.

.DESCRIPTION
Backs up the inbound provisioning mapping to a file. This can be restored to the same service principal or another service principal by using the Restore cmdlet.

.EXAMPLE
Backup-InboundProvisioningMapping -ObjectId e8787a3a-8d85-4ce6-98e7-d7ff17158ce6
#>
function Backup-InboundProvisioningMapping {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $ObjectId,

        [Parameter(Mandatory = $false)]
        [string] $File = $null
    )

    process {
        $ServicePrincipal = Get-InboundProvisioningServicePrincipal -ObjectId $ObjectId
        $Job = Get-MgServicePrincipalSynchronizationJob -ServicePrincipalId $ServicePrincipal.Id
        
        $url = "https://graph.microsoft.com/v1.0/servicePrincipals/{0}/synchronization/jobs/{1}/schema" -f $ServicePrincipal.Id, $Job.Id
        $JobSchema = Invoke-MgGraphRequest -Uri $Url -Method Get
                
        if(!$File) {
            $File = "backup-inbound-provisioning-$($ServicePrincipal.Id)-{0}.json" -f (Get-Date).ToString("yyyyMMdd-HHmmss")
        }

        Write-Verbose "Saving backup to $File"
        $JobSchema | ConvertTo-Json -Depth 100 | Out-File $File
    }
}