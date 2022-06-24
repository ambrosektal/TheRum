
$directories = (gci -Recurse -Filter "latest.json" | where-object {$_.Length -gt 8000}).Directory

foreach($directory in $directories){
	# cd $directory
	$files = $(gc $directory\latest.json | convertfrom-json)
	
	if (!$(Test-Path $directory\$($_.version)\$($_.targetPlatform))) {
		($files.versions).foreach({$(mkdir $directory\$($_.version)\$($_.targetPlatform) ) })	
		($files.versions).foreach({$(cd $directory\$($_.version)\$($_.targetPlatform) && ($_.files.source).foreach({Invoke-WebRequest $_ -OutFile $_.Split("/")[-1]  }) ) })
	} else {
		Write-Host "Newest version of $directory\$($_.version)\$($_.targetPlatform) already exists"
	}
	
}
# Remove extensions with under X installs
# (gc latest.json | convertfrom-json).statistics.GetValue(0).value
(gci -Recurse -Filter "latest.json" | where-object {(gc $_ | convertfrom-json).statistics.GetValue(0).value -lt 10000 }).Directory 


