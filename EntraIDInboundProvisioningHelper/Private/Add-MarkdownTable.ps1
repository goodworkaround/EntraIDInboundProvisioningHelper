function Add-MarkdownTable {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true, Position = 0)]
        [String[]] $Headers,

        [Parameter(Mandatory = $false, Position = 1, ValueFromPipeline = $true)]
        $InputObject = $null
    )

    Begin {
        Start-MarkdownTable -Headers $Headers
    }
    Process {
        Add-Markdown ("| {0} | " -f (($Headers | ForEach-Object {$InputObject.$_}) -join " | ")) -NoNewLine
    }
    End {
        Add-Markdown
    }
}