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