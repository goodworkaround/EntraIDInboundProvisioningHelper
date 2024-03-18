function Backup-InboundProvisioningMapping {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $ObjectId,

        [Parameter(Mandatory = $false)]
        [string] $File = "backup.json"
    )

    process {
        Confirm-InboundProvisioningConnection

        $ServicePrincipal = Get-MgServicePrincipal -ServicePrincipalId $ObjectId

        if($ServicePrincipal.ApplicationTemplateId -eq "ec7c5431-5d84-453f-80d3-e3385e284eef") {
            Write-Verbose "Service principal is for synching to Active Directory"
            
            # TODO: Find correct template id for Entra ID as this is created by copilot
        } elseif($ServicePrincipal.ApplicationTemplateId -eq "c3c0e67f-580b-4e9e-9e3f-7f3e1b6a6f9c") {
            Write-Verbose "Service principal is for synching to Entra ID"
        } else {
            throw "Service principal is not for inbound provisioning"
        }

        $Job = Get-MgServicePrincipalSynchronizationJob -ServicePrincipalId $ObjectId
        
        $url = "https://graph.microsoft.com/v1.0/servicePrincipals/{0}/synchronization/jobs/{1}/schema" -f $ObjectId, $Job.Id
        $JobSchema = Invoke-MgGraphRequest -Uri $Url -Method Get
        
        Write-Verbose "Saving backup to $File"
        $JobSchema | ConvertTo-Json -Depth 100 | Out-File $File
    }
}