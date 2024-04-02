function Restart-Markdown {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false, Position = 0)]
        [String] $InitialHeader = $null
    )
    Process {
        $Script:markdown = New-Object System.Collections.ArrayList

        if($InitialHeader) {
            Add-MarkdownHeader -Text $InitialHeader
        }
    }
}