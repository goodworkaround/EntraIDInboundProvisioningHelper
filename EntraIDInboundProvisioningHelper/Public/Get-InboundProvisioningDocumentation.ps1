function Get-InboundProvisioningDocumentation {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $ObjectId,
        
        [Parameter(Mandatory = $false)]
        [string] $Title = "Inbound Provisioning documentation",

        [Parameter(Mandatory = $false)]
        [switch] $SuperDetailed,

        [Parameter(Mandatory = $false)]
        [switch] $DoNotIncludeDirectories
    )

    process {
        $ServicePrincipal = Get-InboundProvisioningServicePrincipal -ObjectId $ObjectId
        $Job = Get-MgServicePrincipalSynchronizationJob -ServicePrincipalId $ServicePrincipal.Id

        $url = "https://graph.microsoft.com/v1.0/servicePrincipals/{0}/synchronization/jobs/{1}/schema" -f $ServicePrincipal.Id, $Job.Id
        $JobSchema = Invoke-MgGraphRequest -Uri $Url -Method Get        

        Restart-Markdown -InitialHeader $Title
        Add-Markdown ("This document describes the inbound provisioning job for the service principal **$($ServicePrincipal.DisplayName)**, which is configured to synchronize users to {0}." -f ($ServicePrincipal.ApplicationTemplateId -eq "ec7c5431-5d84-453f-80d3-e3385e284eef" ? "Active Directory" : "Entra ID")) 

        @{
            "Property" = "Service principal displayname"
            "Value"    = $ServicePrincipal.DisplayName
        }, 
        @{
            "Property" = "Service principal objectid"
            "Value"    = $ServicePrincipal.Id
        }, 
        @{
            "Property" = "Service principal clientid"
            "Value"    = $ServicePrincipal.AppId
        }, 
        @{
            "Property" = "Inbound provisioning target type"
            "Value"    = ($ServicePrincipal.ApplicationTemplateId -eq "ec7c5431-5d84-453f-80d3-e3385e284eef" ? "Active Directory" : "Entra ID")
        }, 
        @{
            "Property" = "Provisioning API endpoint"
            "Value"    = "https://graph.microsoft.com/v1.0/servicePrincipals/$($ServicePrincipal.Id)/synchronization/jobs/$($Job.Id)/bulkUpload"
        }, 
        @{
            "Property" = "Provisioning state"
            "Value"    = $Job.Schedule.State
        } | 
        Add-MarkdownTable -Headers "Property", "Value"

        if (!$DoNotIncludeDirectories.IsPresent) {
            Add-MarkdownHeader "Directories" -Level 2

            Foreach ($Directory in $JobSchema.directories) {

                Add-MarkdownHeader $Directory.name -Level 3

                if ($SuperDetailed.IsPresent) {
                    @{
                        "Property" = "Name"
                        "Value"    = $Directory.name
                    }, 
                    @{
                        "Property" = "Id"
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
        }

        # Add-MarkdownHeader "Synchronization rules" -Level 2

        Foreach ($SyncRule in $JobSchema.synchronizationRules) {

            if($SuperDetailed.IsPresent) {
                Add-MarkdownHeader "Synchronization rule - $($SyncRule.name)" -Level 2
            } else {
                Add-MarkdownHeader "Synchronization rule" -Level 2
            }
            # Add-MarkdownHeader $SyncRule.name -Level 3

            if ($SuperDetailed.IsPresent) {
                @{
                    "Property" = "Id"
                    "Value"    = $SyncRule.id
                },
                @{
                    "Property" = "Synchronization rule name"
                    "Value"    = $SyncRule.name
                },
                @{
                    "Property" = "Source directory name"
                    "Value"    = $SyncRule.sourceDirectoryName
                },
                @{
                    "Property" = "Target directory name"
                    "Value"    = $SyncRule.targetDirectoryName
                },
                @{
                    "Property" = "Priority"
                    "Value"    = $SyncRule.priority
                } | 
                Add-MarkdownTable -Headers "Property", "Value"
            }

            Foreach ($ObjectMapping in $SyncRule.objectMappings) {
                Add-MarkdownHeader "Object mapping - $($ObjectMapping.name)" -Level 3

                if ($SuperDetailed.IsPresent) {
                    @{
                        "Property" = "Object mapping name"
                        "Value"    = $ObjectMapping.name
                    },
                    @{
                        "Property" = "Enabled"
                        "Value"    = $ObjectMapping.enabled
                    },
                    @{
                        "Property" = "Source object name"
                        "Value"    = $ObjectMapping.sourceObjectName
                    },
                    @{
                        "Property" = "Target object name"
                        "Value"    = $ObjectMapping.targetObjectName
                    },
                    @{
                        "Property" = "Flow types"
                        "Value"    = $ObjectMapping.flowTypes
                    } | 
                    Add-MarkdownTable -Headers "Property", "Value"
                }

                Add-MarkdownHeader "Attribute mappings" -Level 4

                Foreach ($AttributeMapping in $ObjectMapping.attributeMappings) {
                    Add-MarkdownHeader $AttributeMapping.targetAttributeName -Level 5
            
                    @{
                        "Property" = "Matching priority"
                        "Value"    = $AttributeMapping.matchingPriority
                    },
                    @{
                        "Property" = "Flow type"
                        "Value"    = $AttributeMapping.flowType
                    } | 
                    Add-MarkdownTable -Headers "Property", "Value"

                    Add-Markdown "**Expression:**"
                    $AttributeMapping.source.expression | Format-InboundProvisioningExpression | Add-Markdown -Code
                }
            }
        }

        Get-Markdown
    }
}