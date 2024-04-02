function Get-Markdown {
    [CmdletBinding()]
    Param()
    Process {
        $Script:markdown -join "`n"
    }
}