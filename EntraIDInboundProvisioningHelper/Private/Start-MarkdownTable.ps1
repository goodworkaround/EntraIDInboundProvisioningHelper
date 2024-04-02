function Start-MarkdownTable {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true, Position = 0)]
        [String[]] $Headers
    )
    Process {
        Add-Markdown ("| {0} |" -f ($Headers -join " | ")) -NoNewLine
        # Add-Markdown ("|-{0}-|" -f (($Headers | ForEach-Object { "-" * ($_.Length)}) -join "-|-")) -NoNewLine
        Add-Markdown ("| :---{0} |" -f (($Headers | ForEach-Object { " | :---" }) -join "")) -NoNewLine
    }
}