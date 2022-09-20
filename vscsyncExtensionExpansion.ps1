
$directories = (gci -Recurse -Filter "latest.json" | where-object {$_.Length -gt 7000}).Directory

foreach($directory in $directories){
	# cd $directory
	$files = $(gc $directory\latest.json | convertfrom-json)
	
	# if (!$(Test-Path $directory\$($_.version)\$($_.targetPlatform))) {
		($files.versions).foreach({$(mkdir $directory\$($_.version)\$($_.targetPlatform) ) })	
		($files.versions).foreach({$(cd $directory\$($_.version)\$($_.targetPlatform) && ($_.files.source).foreach({Invoke-WebRequest $_ -OutFile $_.Split("/")[-1]  }) ) })
	# } else {
		# Write-Host "Newest version of $directory\$($_.version)\$($_.targetPlatform) already exists"
	# }
}


# Remove extensions with under X installs
# (gc latest.json | convertfrom-json).statistics.GetValue(0).value
# (gci -Recurse -Filter "latest.json" | where-object {(gc $_ | convertfrom-json).statistics.GetValue(0).value -lt 10000 }).Directory | rm -r -force
(((gci -Recurse -Filter "latest.json" | where-object {(gc $_ | convertfrom-json).statistics.GetValue(0).value -lt 5000 }).Directory) | Where-Object {($_.Name -notlike "ms-*") -and ($_.Name -notlike "*svelte*")}).count
# (((gci -Recurse -Filter "latest.json" | where-object {(gc $_ | convertfrom-json).statistics.GetValue(0).value -lt 5000 }).Directory) | Where-Object {($_.Name -notlike "ms-*") -and ($_.Name -notlike "*svelte*")}) | rm -r -Force


# clean up specified.json
$currentNames = <"paste in list from json">
$removeNames = (((gci -Recurse -Filter "latest.json" | where-object {(gc $_ | convertfrom-json).statistics.GetValue(0).value -lt 5000 }).Directory) | Where-Object {($_.Name -notlike "ms-*") -and ($_.Name -notlike "*svelte*")}).name
($currentNames | Where-Object {$_ -notin $removeNames})
# Paste the output into the json

# Remove the folders from the cache, based on number of downloads.
(((gci -Recurse -Filter "latest.json" | where-object {(gc $_ | convertfrom-json).statistics.GetValue(0).value -lt 5000 }).Directory) | Where-Object {($_.Name -notlike "ms-*") -and ($_.Name -notlike "*svelte*")}) | rm -r -Force


# Finding folders modified only in the last X days
gci -Recurse | Where{$($_.GetType().Name -eq "DirectoryInfo") -and $($_.LastWriteTime -ge (Get-Date).AddDays(-7))}

# Finding files modified only in the last X days
gci -Recurse | Where{$($_.GetType().Name -eq "FileInfo") -and $($_.LastWriteTime -ge (Get-Date).AddDays(-7))}

# finding files that are older than X days:
gci -Recurse | Where{$($_.GetType().Name -eq "FileInfo") -and $($_.LastWriteTime -le (Get-Date).AddDays(-2))} 

# tgz files modified in the last 12 hours
$bunFiles = gci -Recurse -Filter "*.tgz" | Where-Object {$_.LastWriteTime -ge (Get-Date).AddHours(-12) }