function Add-MarkdownHeader {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true, Position = 0)]
        [String] $Text,

        [Parameter(Mandatory = $false, Position = 1)]
        [ValidateRange(1, 6)]
        [Int] $Level = 1
    )
    Process {
        $Script:markdown.Add(("{0} {1}" -f ("#" * $Level), $Text)) | Out-Null
        $Script:markdown.Add("") | Out-Null
    }
}