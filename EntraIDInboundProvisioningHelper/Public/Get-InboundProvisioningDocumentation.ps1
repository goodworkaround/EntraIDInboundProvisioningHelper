function Get-InboundProvisioningDocumentation {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $ObjectId,
        
        [Parameter(Mandatory = $false)]
        [string] $Title = "Inbound Provisioning Documentation",

        [Parameter(Mandatory = $false)]
        [switch] $SuperDetailed
    )

    process {
        $ServicePrincipal = Get-InboundProvisioningServicePrincipal -ObjectId $ObjectId
        $Job = Get-MgServicePrincipalSynchronizationJob -ServicePrincipalId $ServicePrincipal.Id

        $url = "https://graph.microsoft.com/v1.0/servicePrincipals/{0}/synchronization/jobs/{1}/schema" -f $ServicePrincipal.Id, $Job.Id
        $JobSchema = Invoke-MgGraphRequest -Uri $Url -Method Get
                
        

        Restart-Markdown -InitialHeader $Title
        Add-Markdown ("This document describes the inbound provisioning job for the service principal **$($ServicePrincipal.DisplayName)**, which is configured to synchronize users to {0}." -f ($ServicePrincipal.ApplicationTemplateId -eq "ec7c5431-5d84-453f-80d3-e3385e284eef" ? "Active Directory" : "Entra ID")) 

        @{
            "Property" = "Service Principal DisplayName"
            "Value"    = $ServicePrincipal.DisplayName
        }, 
        @{
            "Property" = "Service Principal ObjectId"
            "Value"    = $ServicePrincipal.Id
        }, 
        @{
            "Property" = "Service Principal ClientId"
            "Value"    = $ServicePrincipal.AppId
        }, 
        @{
            "Property" = "Inbound Provisioning Target Type"
            "Value"    = ($ServicePrincipal.ApplicationTemplateId -eq "ec7c5431-5d84-453f-80d3-e3385e284eef" ? "Active Directory" : "Entra ID")
        }, 
        @{
            "Property" = "Provisioning API Endpoint"
            "Value"    = "https://graph.microsoft.com/v1.0/servicePrincipals/$($ServicePrincipal.Id)/synchronization/jobs/$($Job.Id)/bulkUpload"
        }, 
        @{
            "Property" = "Provisioning State"
            "Value"    = $Job.Schedule.State
        } | 
        Add-MarkdownTable -Headers "Property", "Value"

        Add-MarkdownHeader "Directories" -Level 2

        Foreach ($Directory in $JobSchema.directories) {
            Add-MarkdownHeader $Directory.name -Level 3

            if ($SuperDetailed.IsPresent) {
                @{
                    "Property" = "name"
                    "Value"    = $Directory.name
                }, 
                @{
                    "Property" = "id"
                    "Value"    = $Directory.id
                } | 
                Add-MarkdownTable -Headers "Property", "Value"
            }

            Foreach ($Object in $Directory.objects) {
                Add-MarkdownHeader $Object.name -Level 4

                if ($SuperDetailed.IsPresent) {
                    $Object.metadata | 
                    Add-MarkdownTable -Headers "Key", "Value"
                }

                Add-MarkdownHeader "Attributes" -Level 5

                $Object.attributes | 
                Sort-Object -Property Name | 
                Add-MarkdownTable -Headers "Name", "Type", "Mutability", "Multivalued", "FlowNullValues", "Required", "CaseExact"
            }
        }

        Add-MarkdownHeader "Synchronization rules" -Level 2

        Foreach ($SyncRule in $JobSchema.synchronizationRules) {
            Add-MarkdownHeader $SyncRule.name -Level 3

            if ($SuperDetailed.IsPresent) {
                @{
                    "Property" = "id"
                    "Value"    = $SyncRule.id
                },
                @{
                    "Property" = "name"
                    "Value"    = $SyncRule.name
                },
                @{
                    "Property" = "sourceDirectoryName"
                    "Value"    = $SyncRule.sourceDirectoryName
                },
                @{
                    "Property" = "targetDirectoryName"
                    "Value"    = $SyncRule.targetDirectoryName
                },
                @{
                    "Property" = "priority"
                    "Value"    = $SyncRule.priority
                } | 
                Add-MarkdownTable -Headers "Property", "Value"
            }

            Foreach ($ObjectMapping in $SyncRule.objectMappings) {
                Add-MarkdownHeader $ObjectMapping.name -Level 4

                if ($SuperDetailed.IsPresent) {
                    @{
                        "Property" = "name"
                        "Value"    = $ObjectMapping.name
                    },
                    @{
                        "Property" = "enabled"
                        "Value"    = $ObjectMapping.enabled
                    },
                    @{
                        "Property" = "sourceObjectName"
                        "Value"    = $ObjectMapping.sourceObjectName
                    },
                    @{
                        "Property" = "targetObjectName"
                        "Value"    = $ObjectMapping.targetObjectName
                    },
                    @{
                        "Property" = "flowTypes"
                        "Value"    = $ObjectMapping.flowTypes
                    } | 
                    Add-MarkdownTable -Headers "Property", "Value"
                }

                Add-MarkdownHeader "Attribute mappings" -Level 5

                Foreach ($AttributeMapping in $ObjectMapping.attributeMappings) {
                    Add-MarkdownHeader $AttributeMapping.targetAttributeName -Level 6
            
                    @{
                        "Property" = "matchingPriority"
                        "Value"    = $AttributeMapping.matchingPriority
                    },
                    @{
                        "Property" = "flowType"
                        "Value"    = $AttributeMapping.flowType
                    },
                    @{
                        "Property" = "flowBehavior"
                        "Value"    = $AttributeMapping.flowBehavior
                    },
                    @{
                        "Property" = "flowBehavior"
                        "Value"    = $AttributeMapping.flowBehavior
                    } | 
                    Add-MarkdownTable -Headers "Property", "Value"

                    $AttributeMapping.source.expression | Format-InboundProvisioningExpression | Add-Markdown -Code
                }
            }
        }

        Get-Markdown
    }
}