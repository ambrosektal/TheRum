## This method originally failed because it tried a ping after the connect and that came back with a success...
# # Could use this, but testing the return prop instead:
# $ipaddress = IP_Address_Server 
# $port = port 
# $connection = New-Object System.Net.Sockets.TcpClient($ipaddress, $port)
# if ($connection.Connected) {
#      Write-Host "Success" 
# } else { 
#      Write-Host "Failed" 
# }

$fullpath = "D:\Transfer\ToMove\node"

Set-Location -Path $fullpath

$allfiles = gci "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\*.txt"
$files = $allfiles.foreach({get-content $_ })
# get-content $_files = Get-Content "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\Top1000NpmPackages.txt"
# $files += Get-Content  "C:\Users\$env:USERNAME\Downloads\gits\TheRum\npmPackageFiles\TopPackages.txt"
$files = $files | Sort-Object | Get-unique
# $files=$files[1550..3259]
$count = 0

while($count -lt 5){
    $count++
    write-host "$count atempts so far."
    if (!$(Test-NetConnection -ComputerName 127.0.0.1 -Port 4873).TcpTestSucceeded ) { 
        write-host "failed to connect. Is the container running???"
        Write-Host "Attempting to start the container..."
        docker start cranky_margulis
        # try {
        #     docker start cranky_margulis
        # }
        # catch {
        #     docker run --name cranky_margulis -p 4873:4873 -v "D:\Transfer\ToMove\software\verdaccio\storage\data:/verdaccio/storage/data" verdaccio/verdaccio:latest
        #     start-sleep 15
        # }
        
    } elseif ($(Test-NetConnection -ComputerName 127.0.0.1 -Port 4873).TcpTestSucceeded ) {
        write-host "success"  
        if ($(Get-Location ).Path -notlike $fullpath ) {
            Write-Host "I'm not where I expected I was. I'm quitting."
            break;
        } else {
            Write-Host "yay, I'm in the correct directory!!!"
            $files.foreach({
                write-host "Downloading $_ ..."
                npm i $_ --force ; 
                npm audit fix ; 
                npm audit fix --force ; 
                Remove-Item -r -Force "$fullpath\*"
                [System.GC]::Collect()
            })
        }
    } else {
        Write-Host "Unable to connect to the container."
        Write-Host "Quitting out of attempts."
    }
}



