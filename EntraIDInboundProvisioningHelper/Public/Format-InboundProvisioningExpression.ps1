<#
.DESCRIPTION
Formats an Inbound Provisioning Sync Rule expression for better readability
#>
function Format-InboundProvisioningExpression {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string] $SyncRule,

        [Parameter(Mandatory = $false)]
        [string] $IndentationCharacters = "    "
    )

    process {
        # $SyncRule = 'Switch([active], "False", "False", "True", "True", "False")'
        # $SyncRule = 'Replace(Join("", "OU=Elever,OU=", [urn:ietf:params:scim:schemas:extension:iktagder:1.0:User:schoolcode], ",OU=", [urn:ietf:params:scim:schemas:extension:iktagder:1.0:User:schoolregionname], ",OU=Agderskolen,OU=IKT Agder,DC=entraidpoc,DC=iktagder,DC=no"), , "(\\W|\\w)+=,(\\W|\\w)+", , "OU=Default elev OU,OU=IKT Agder,DC=entraidpoc,DC=iktagder,DC=no", , )'

        $InString = $false
        $IsEscaped = $false
        $IndentationLevel = 0
        $NewLineAfter = $false
        $IndentAdjustmentAfter = 0
        $PreviusCharacter = $null

        ($SyncRule.ToCharArray() | 
        ForEach-Object {
            if ($_ -eq ' ' -and !$InString) {
                # Do nothing with spaces not in strings
                return
            } elseif ($_ -eq '(' -and !$InString) {
                $NewLineAfter = $true
                $IndentationLevel += 1
            }
            elseif ($_ -eq ')' -and !$InString) {
                $NewLineAfter = $false
                $IndentationLevel -= 1
                "`n"
                for ($i = $IndentationLevel; $i -gt 0; $i--) {
                    $IndentationCharacters
                }
            }
            elseif ($_ -eq ',' -and !$InString) {
                $NewLineAfter = $true
            }
            elseif ($_ -eq '\' -and !$IsEscaped) {
                $IsEscaped = $true
            }
            elseif ($_ -eq '"' -and !$InString) {
                $InString = $true
            }
            elseif ($_ -eq '"' -and $InString -and !$IsEscaped) {
                $InString = $false
            }
            elseif($IsEscaped) {
                $IsEscaped = $false
            }
            elseif ($InString) {

            }
            else {

            }

            "$($_)"

            $PreviusCharacter = $_

            if ($NewLineAfter) {
                $NewLineAfter = $false
                "`n"

                for ($i = $IndentationLevel; $i -gt 0; $i--) {
                    $IndentationCharacters
                }
            }
            if ($IndentAdjustmentAfter -ne 0) {
                $IndentationLevel += $IndentAdjustmentAfter
                $IndentAdjustmentAfter = 0                
            }
            
            
        }) -join ""
    }
}