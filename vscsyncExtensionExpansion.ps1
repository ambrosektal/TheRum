
$directories = (gci -Recurse -Filter "latest.json" | where-object {$_.Length -gt 8000}).Directory

foreach($directory in $directories){
	# cd $directory
	$files = $(gc $directory\latest.json | convertfrom-json)
	($files.versions).foreach({$(mkdir $directory\$($_.version)\$($_.targetPlatform) ) })

	($files.versions).foreach({$(cd $directory\$($_.version)\$($_.targetPlatform) && ($_.files.source).foreach({Invoke-WebRequest $_ -OutFile $_.Split("/")[-1]  }) ) })
}