$dirs = gci -Directory

$dirs.foreach({mkdir $_\pictures })
$dirs.foreach({mkdir $_\archives })
$dirs.foreach({mkdir $_\videos })
$dirs.foreach({mkdir $_\binaries })
$dirs.foreach({mkdir $_\audio\})
$dirs.foreach({mkdir $_\presentation\})
$dirs.foreach({mkdir $_\database\})
$dirs.foreach({mkdir $_\spreadsheets\})
$dirs.foreach({mkdir $_\publishing\})
$dirs.foreach({mkdir $_\math\})
$dirs.foreach({mkdir $_\otheroffice\})
$dirs.foreach({mkdir $_\commonoffice\})


# # $filetypes = "gif","jpg","jpeg","png","bmp"
# # $filetypes = 'zip','7z','rar','tar','gz','xz','bz','zlib'
# # $filetypes = 'exe','msi','com'
# # $filetypes = '3g2', '3gp', 'asf', 'avi', 'flv', 'm4v', 'mkv', 'mov', 'mp4', 'mpg', 'mpeg', 'rm', 'swf', 'vob', 'wmv', 'webm', 'ogv', 'qt'
# # $filetypes = 'aac', 'aif', 'aiff', 'amr', 'au', 'flac', 'm4a', 'mp3', 'ogg', 'wav', 'wma', 'weba', 'opus'
# # $filetypes = 'xls', 'xlsx', 'xlsm', 'xlsb', 'xlt', 'xltx', 'xltm', 'ods', 'csv', 'tsv', 'gnumeric', '123', 'wk1', 'wk3', 'wk4', 'wks'
# # $filetypes = 'ppt', 'pptx', 'pps', 'ppsx', 'pot', 'potx', 'odp', 'sda', 'sdd', 'shw', 'show', 'sti', 'key'
# $filetypes = 'odb', 'mdb', 'accdb', 'dbf', 'fp7', 'sqlite', 'sqlite3', 'sql', 'db'
# # $filetypes = 'pub', 'mcf', 'indd', 'idml', 'pmd', 'sla', 'sla.gz', 'scd', 'stc', 'sxg', 'ott', 'dotm', 'dotx'
# # $filetypes = 'odf', 'mml', 'sxm', 'smf'
# # $filetypes = 'odc', 'oth', 'otp', 'ots', 'xsd', 'xsl', 'dtd', 'one', 'enex', 'vsd', 'vsdx', 'vdx', 'vdw', 'vss', 'vst', 'vtx', 'vsx', 'vsl', 'vssx', 'vstx', 'vsw', 'odg', 'otg', 'drawio', 'xml', 'xmlx'
# # $filetypes = 'doc', 'docx', 'dot', 'dotx', 'odt', 'rtf', 'txt', 'pdf', 'wps', 'wpd', 'abw', 'lwp'




# foreach($dir in $dirs){ 
#     Foreach($filetype in $filetypes){
#         # $files = Get-ChildItem -LiteralPath $dir -File -Filter "*.$filetype" 
#         $files = Get-ChildItem -LiteralPath $dir -Recurse -File -Filter "*.$filetype" 
#         ForEach-Object { 
#             # gci -LiteralPath "$($_.DirectoryName)\images" 
#             # $files | Move-Item -Destination "$dir\images\"
#             # $files | Move-Item -Destination "$dir\archives\"
#             # $files | Move-Item -Destination "$dir\binaries\"
#             # $files | Move-Item -Destination "$dir\videos\"
#             # $files | Move-Item -Destination "$dir\audio\"
#             # $files | Move-Item -Destination "$dir\presentation\"
#             $files | Move-Item -Destination "$dir\database\"
#             # $files | Move-Item -Destination "$dir\spreadsheets\"
#             # $files | Move-Item -Destination "$dir\publishing\"
#             # $files | Move-Item -Destination "$dir\math\"
#             # $files | Move-Item -Destination "$dir\otheroffice\"
#             # $files | Move-Item -Destination "$dir\commonoffice\"
#             # $files 
#         } 
#     }
# }




$filetypes = "gif","jpg","jpeg","png","bmp"

foreach($dir in $dirs){ 
    Foreach($filetype in $filetypes){
        # $files = Get-ChildItem -LiteralPath $dir -File -Filter "*.$filetype" 
        $files = Get-ChildItem -LiteralPath $dir -Recurse -File -Filter "*.$filetype" 
        ForEach-Object { 
            $files | Foreach-Object -Parallel { 
                # Write-Host "Move-Item $_ -Destination "$dir\images\""
                $dir = $using:dir
                Move-Item $_ -Destination "$dir\images\$($_.Name)"
            }
        } 
    }
}

###########################################

$filetypes = 'zip','7z','rar','tar','gz','xz','bz','zlib'


foreach($dir in $dirs){ 
    Foreach($filetype in $filetypes){
        # $files = Get-ChildItem -LiteralPath $dir -File -Filter "*.$filetype" 
        $files = Get-ChildItem -LiteralPath $dir -Recurse -File -Filter "*.$filetype" 
        ForEach-Object { 
            $files | Foreach-Object -Parallel { 
                # Write-Host "Move-Item $_ -Destination "$dir\images\""
                $dir = $using:dir
                Move-Item $_ -Destination "$dir\archives\$($_.Name)"
            }
        } 
    }
}



###########################################

$filetypes = 'exe','msi','com'



foreach($dir in $dirs){ 
    Foreach($filetype in $filetypes){
        # $files = Get-ChildItem -LiteralPath $dir -File -Filter "*.$filetype" 
        $files = Get-ChildItem -LiteralPath $dir -Recurse -File -Filter "*.$filetype" 
        ForEach-Object { 
            $files | Foreach-Object -Parallel { 
                # Write-Host "Move-Item $_ -Destination "$dir\images\""
                $dir = $using:dir
                Move-Item $_ -Destination "$dir\binaries\$($_.Name)"
            }
        } 
    }
}


###########################################


$filetypes = '3g2', '3gp', 'asf', 'avi', 'flv', 'm4v', 'mkv', 'mov', 'mp4', 'mpg', 'mpeg', 'rm', 'swf', 'vob', 'wmv', 'webm', 'ogv', 'qt'

foreach($dir in $dirs){ 
    Foreach($filetype in $filetypes){
        # $files = Get-ChildItem -LiteralPath $dir -File -Filter "*.$filetype" 
        $files = Get-ChildItem -LiteralPath $dir -Recurse -File -Filter "*.$filetype" 
        ForEach-Object { 
            $files | Foreach-Object -Parallel { 
                # Write-Host "Move-Item $_ -Destination "$dir\images\""
                $dir = $using:dir
                Move-Item $_ -Destination "$dir\videos\$($_.Name)"
            }
        } 
    }
}


###########################################


$filetypes = 'aac', 'aif', 'aiff', 'amr', 'au', 'flac', 'm4a', 'mp3', 'ogg', 'wav', 'wma', 'weba', 'opus'


foreach($dir in $dirs){ 
    Foreach($filetype in $filetypes){
        # $files = Get-ChildItem -LiteralPath $dir -File -Filter "*.$filetype" 
        $files = Get-ChildItem -LiteralPath $dir -Recurse -File -Filter "*.$filetype" 
        ForEach-Object { 
            $files | Foreach-Object -Parallel { 
                # Write-Host "Move-Item $_ -Destination "$dir\images\""
                $dir = $using:dir
                Move-Item $_ -Destination "$dir\audio\$($_.Name)"
            }
        } 
    }
}


###########################################


$filetypes = 'xls', 'xlsx', 'xlsm', 'xlsb', 'xlt', 'xltx', 'xltm', 'ods', 'csv', 'tsv', 'gnumeric', '123', 'wk1', 'wk3', 'wk4', 'wks'

foreach($dir in $dirs){ 
    Foreach($filetype in $filetypes){
        # $files = Get-ChildItem -LiteralPath $dir -File -Filter "*.$filetype" 
        $files = Get-ChildItem -LiteralPath $dir -Recurse -File -Filter "*.$filetype" 
        ForEach-Object { 
            $files | Foreach-Object -Parallel { 
                # Write-Host "Move-Item $_ -Destination "$dir\images\""
                $dir = $using:dir
                Move-Item $_ -Destination "$dir\spreadsheets\$($_.Name)"
            }
        } 
    }
}


###########################################

$filetypes = 'ppt', 'pptx', 'pps', 'ppsx', 'pot', 'potx', 'odp', 'sda', 'sdd', 'shw', 'show', 'sti', 'key'

foreach($dir in $dirs){ 
    Foreach($filetype in $filetypes){
        # $files = Get-ChildItem -LiteralPath $dir -File -Filter "*.$filetype" 
        $files = Get-ChildItem -LiteralPath $dir -Recurse -File -Filter "*.$filetype" 
        ForEach-Object { 
            $files | Foreach-Object -Parallel { 
                # Write-Host "Move-Item $_ -Destination "$dir\images\""
                $dir = $using:dir
                Move-Item $_ -Destination "$dir\presentation\$($_.Name)"
            }
        } 
    }
}


###########################################


$filetypes = 'odb', 'mdb', 'accdb', 'dbf', 'fp7', 'sqlite', 'sqlite3', 'sql', 'db'

foreach($dir in $dirs){ 
    Foreach($filetype in $filetypes){
        # $files = Get-ChildItem -LiteralPath $dir -File -Filter "*.$filetype" 
        $files = Get-ChildItem -LiteralPath $dir -Recurse -File -Filter "*.$filetype" 
        ForEach-Object { 
            $files | Foreach-Object -Parallel { 
                # Write-Host "Move-Item $_ -Destination "$dir\images\""
                $dir = $using:dir
                Move-Item $_ -Destination "$dir\database\$($_.Name)"
            }
        } 
    }
}


###########################################


$filetypes = 'pub', 'mcf', 'indd', 'idml', 'pmd', 'sla', 'sla.gz', 'scd', 'stc', 'sxg', 'ott', 'dotm', 'dotx'

foreach($dir in $dirs){ 
    Foreach($filetype in $filetypes){
        # $files = Get-ChildItem -LiteralPath $dir -File -Filter "*.$filetype" 
        $files = Get-ChildItem -LiteralPath $dir -Recurse -File -Filter "*.$filetype" 
        ForEach-Object { 
            $files | Foreach-Object -Parallel { 
                # Write-Host "Move-Item $_ -Destination "$dir\images\""
                $dir = $using:dir
                Move-Item $_ -Destination "$dir\publishing\$($_.Name)"
            }
        } 
    }
}


###########################################

$filetypes = 'odf', 'mml', 'sxm', 'smf'


foreach($dir in $dirs){ 
    Foreach($filetype in $filetypes){
        # $files = Get-ChildItem -LiteralPath $dir -File -Filter "*.$filetype" 
        $files = Get-ChildItem -LiteralPath $dir -Recurse -File -Filter "*.$filetype" 
        ForEach-Object { 
            $files | Foreach-Object -Parallel { 
                # Write-Host "Move-Item $_ -Destination "$dir\images\""
                $dir = $using:dir
                Move-Item $_ -Destination "$dir\math\$($_.Name)"
            }
        } 
    }
}


###########################################


$filetypes = 'odc', 'oth', 'otp', 'ots', 'xsd', 'xsl', 'dtd', 'one', 'enex', 'vsd', 'vsdx', 'vdx', 'vdw', 'vss', 'vst', 'vtx', 'vsx', 'vsl', 'vssx', 'vstx', 'vsw', 'odg', 'otg', 'drawio', 'xml', 'xmlx'

foreach($dir in $dirs){ 
    Foreach($filetype in $filetypes){
        # $files = Get-ChildItem -LiteralPath $dir -File -Filter "*.$filetype" 
        $files = Get-ChildItem -LiteralPath $dir -Recurse -File -Filter "*.$filetype" 
        ForEach-Object { 
            $files | Foreach-Object -Parallel { 
                # Write-Host "Move-Item $_ -Destination "$dir\images\""
                $dir = $using:dir
                Move-Item $_ -Destination "$dir\otheroffice\$($_.Name)"
            }
        } 
    }
}

###########################################

$filetypes = 'doc', 'docx', 'dot', 'dotx', 'odt', 'rtf', 'txt', 'pdf', 'wps', 'wpd', 'abw', 'lwp'

foreach($dir in $dirs){ 
    Foreach($filetype in $filetypes){
        # $files = Get-ChildItem -LiteralPath $dir -File -Filter "*.$filetype" 
        $files = Get-ChildItem -LiteralPath $dir -Recurse -File -Filter "*.$filetype" 
        ForEach-Object { 
            $files | Foreach-Object -Parallel { 
                # Write-Host "Move-Item $_ -Destination "$dir\images\""
                $dir = $using:dir
                Move-Item $_ -Destination "$dir\commonoffice\$($_.Name)"
            }
        } 
    }
}


###########################################

