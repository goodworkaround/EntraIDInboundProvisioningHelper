function Add-Markdown {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false, Position = 0, ValueFromPipeline)]
        [String] $Text = $null,

        [Parameter(Mandatory = $false, Position = 1)]
        [Switch] $NoNewLine,

        [Parameter(Mandatory = $false, Position = 2)]
        [Switch] $Code
    )

    Begin {
        if($Code.IsPresent) {
            $Script:markdown.Add('```powershell') | Out-Null
        }
    }

    Process {
        if($Text) {
            $Script:markdown.Add($Text) | Out-Null
        }
    }

    End {
        if($Code.IsPresent) {
            $Script:markdown.Add('```') | Out-Null
        }

        if(!$NoNewLine.IsPresent) {
            $Script:markdown.Add("") | Out-Null
        }
    }
}