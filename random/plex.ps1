# Conduct a full gci on a directory and try to move them to a new location and if it already exists, delete the existing file and move the new file to the new location.

$files = gci -Filter *YTS* 
$files | Foreach-Object {
    try {
        # Move-Item $_ -Destination P:\plex\movies -Force -ErrorAction SilentlyContinue
        mv $_.FullName 'P:\plex\movies' 
   }
   catch {
       Write-Host "Error: $_"
    #    Remove-Item -Force -ErrorAction SilentlyContinue -Path $_
   }
   
}





