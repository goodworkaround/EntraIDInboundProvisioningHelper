function Get-InboundProvisioningServicePrincipal {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $ObjectId
    )

    process {
        Confirm-InboundProvisioningConnection
        $ServicePrincipal = Get-MgServicePrincipal -ServicePrincipalId $ObjectId

        if($ServicePrincipal.ApplicationTemplateId -eq "ec7c5431-5d84-453f-80d3-e3385e284eef") {
            Write-Verbose "Service principal is for synching to Active Directory"
        } elseif($ServicePrincipal.ApplicationTemplateId -eq "40d8f01e-b0d7-4b4f-938b-05190712e598") {
            Write-Verbose "Service principal is for synching to Entra ID"
        } else {
            throw "Service principal is not for inbound provisioning"
        }

        $ServicePrincipal
    }
}