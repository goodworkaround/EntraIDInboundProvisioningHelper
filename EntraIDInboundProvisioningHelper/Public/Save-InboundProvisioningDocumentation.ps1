function Save-InboundProvisioningDocumentation {
    [CmdletBinding()]

    Param(
        [Parameter(Mandatory = $true, Position = 0)]
        [String] $ObjectId,

        [Parameter(Mandatory = $false, Position = 1)]
        [String] $PathWithoutExtension = "inbound_provisioning_documentation",

        [Parameter(Mandatory = $false, Position = 1)]
        [ValidateSet("markdown", "html")]
        [String] $Format = "markdown",

        [Parameter(Mandatory = $false, Position = 2)]
        [switch] $SuperDetailed,

        [Parameter(Mandatory = $false, Position = 3)]
        [string] $Title = "Inbound Provisioning Documentation",

        [Parameter(Mandatory = $false, Position = 4)]
        [string] $AdditionalCss = ""
    )

    Process {
        $GeneratedMarkdown = Get-InboundProvisioningDocumentation -ObjectId $ObjectId -Title $Title -SuperDetailed:$SuperDetailed.IsPresent
        $GeneratedDocumentation = $GeneratedMarkdown | ConvertFrom-Markdown

        if($Format -eq "markdown") {
            $OutputFile = "$($PathWithoutExtension).md"
            $GeneratedMarkdown | Out-File -FilePath $OutputFile -Encoding utf8
            return $OutputFile
        } elseif($Format -eq "html") {
            $OutputFile = "$($PathWithoutExtension).html"
            
            $Css = @"
h1 {
    font-size: 3em;
}

h2 {
    font-size: 2.5em;
}

h3 {
    font-size: 2em;
}

h4 {
    font-size: 1.75em;
}

h5 {
    font-size: 1.5em;
}

h6 {
    font-size: 1.3em;
}

table {
    border-collapse: collapse;
    border: 1px solid #dddddd;
}

table td, table th {
    border: 1px solid #dddddd;
    padding: 8px;
}
"@
            "<html><head><style>$Css`n$AdditionalCss</style><title>$Title</title></head><body>$($GeneratedDocumentation.Html)</body></html>" | Out-File -FilePath $OutputFile -Encoding utf8
            return $OutputFile
        }
    }
}