function Save-Download {
    <#
    .SYNOPSIS
        Given a the result of WebResponseObject, will download the file to disk without having to specify a name.
    .DESCRIPTION
        Given a the result of WebResponseObject, will download the file to disk without having to specify a name.
    .PARAMETER WebResponse
        A WebResponseObject from running an Invoke-WebRequest on a file to download
    .EXAMPLE
        # Download Microsoft Edge
        $download = Invoke-WebRequest -Uri "https://go.microsoft.com/fwlink/?linkid=2109047&Channel=Stable&language=en&consent=1"
        $download | Save-Download 

        # $osversions = "win32","linux","linux-deb","linux-rpm","linux-snap","server-linux","server-win32","cli-win32","cli-linux"
        $osversions = "server-win32","cli-win32","cli-linux"
        $arches = "","-x64"
        foreach($osver in $osversions) {
            $(70..83).foreach({ 
                $major = $_
                $(0..5).foreach({
                    $minor = $_
                    Foreach ($arch in $arches){
                        $URL = "https://update.code.visualstudio.com/1.$major.$minor/$osver$arch/stable"
                        invoke-webrequest $URL -OutFile "D:\Transfer\ToMove\vscode\$osver$arch\vscode-1.$major.$minor.zip"
                        }
                    })
                })    
        }


        $osversions = "server-win32","cli-win32","cli-linux"
        $arches = "","-x64"
        foreach($osver in $osversions) {
            $(70..83).foreach({ 
                $major = $_
                $(0..5).foreach({
                    $minor = $_
                    Foreach ($arch in $arches){
                        $URL = "https://update.code.visualstudio.com/1.$major.$minor/$osver$arch/stable"
                        #### $download = invoke-webrequest $URL
                        invoke-webrequest $URL -OutFile "D:\Transfer\ToMove\vscode\$osver$arch\vscode-1.$major.$minor.zip"
                        #### $download | Save-Download -Directory "D:\Transfer\ToMove\vscode\$osver$arch\ "
                        }
                    })
                })    
        }



    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline)]
        [Microsoft.PowerShell.Commands.WebResponseObject]
        $WebResponse,

        [Parameter(Mandatory = $false)]
        [string]
        $Directory = "."
    )

    $errorMessage = "Cannot determine filename for download."

    if (!($WebResponse.Headers.ContainsKey("Content-Disposition"))) {
        Write-Error $errorMessage -ErrorAction Stop
    }

    $content = [System.Net.Mime.ContentDisposition]::new($WebResponse.Headers["Content-Disposition"])
    
    $fileName = $content.FileName

    if (!$fileName) {
        Write-Error $errorMessage -ErrorAction Stop
    }

    if (!(Test-Path -Path $Directory)) {
        New-Item -Path $Directory -ItemType Directory
    }
    
    $fullPath = Join-Path -Path $Directory -ChildPath $fileName

    Write-Verbose "Downloading to $fullPath"

    $file = [System.IO.FileStream]::new($fullPath, [System.IO.FileMode]::Create)
    $file.Write($WebResponse.Content, 0, $WebResponse.RawContentLength)
    $file.Close()
}