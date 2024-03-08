helm 

helm repo add jetstack https://charts.jetstack.io
helm repo update
helm fetch jetstack/cert-manager

helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable
helm repo add rancher-alpha https://releases.rancher.com/server-charts/alpha
helm repo add longhorn https://charts.longhorn.io
helm repo add fleet https://rancher.github.io/fleet-helm-charts/
https://github.com/rancher/rancher




helm repo update

cd D:\Transfer\ToMove\helm

helm fetch rancher-latest/rancher

helm fetch rancher-stable/rancher

helm search repo rancher
helm search repo

$files = (helm search repo )

$files.foreach({ $_.Split(" ")[0].Split("`t")[0] }).foreach({ helm pull $_ })

# List all the charts in the stable repository with the versions
helm search repo -l stable

helm search repo -l stable/rancher

# List all the charts and version in every repository added.
helm search repo -l

# Pull every chart for every version in every repository added.
helm search repo -l | foreach ({ $_.Split(" ")[0].Split("`t")[0] }).foreach({ helm pull $_ })

########################################################################################################


# Search the helm repo and get the output
$helmOutput = helm search repo -l

# Split the output into lines, skip the header
$lines = $helmOutput -split "`n" | Select-Object -Skip 1

# Process each line
$charts = $lines | ForEach-Object {
    # Split the line into parts
    $parts = $_ -split '\s+', 5
    if ($parts.Length -gt 1) {
        # Create a custom object with chart name and version
        [PSCustomObject]@{
            Name    = $parts[0]
            Version = $parts[1]
        }
    }
} | Where-Object { $_ -ne $null }

# Group by chart name
$groupedCharts = $charts | Group-Object -Property Name

# For each group, take the first two versions (0 and 1 indexes)
$groupedCharts | ForEach-Object {
    $chartName = $_.Name
    $versions = $_.Group | Select-Object -First 2
    $versions | ForEach-Object {
        # For demonstration, just printing out. You can replace this with `helm pull` command
        Write-Output "Chart: $chartName, Version: $($_.Version)"
    }
}



########################################################################################################
# Pull the versions of the charts from the helm repo
# This script will pull the first 10 versions of each chart from the helm repo
# and save them in the current directory
# Usage: ./pull-charts.ps1
# Prerequisites: helm must be installed and configured
# Note: This script is for demonstration purposes only. It will not work as is.
#       You need to replace the `Write-Output` line with `helm pull` command
#       to actually pull the charts
#       Also, you need to replace the `helm search repo` command with the actual
#       command to search the helm repo
#       This script is written in PowerShell
#       You can run this script in PowerShell or in a PowerShell script file
#       (with .ps1 extension)
#       You can also run this script in a bash script file by using `pwsh` command
#       to run the PowerShell script
#       Example: pwsh ./pull-charts.ps1

helm repo update

# Search the helm repo and get the output
$helmOutput = helm search repo -l

# Split the output into lines, skip the header
$lines = $helmOutput -split "`n" | Select-Object -Skip 1

# Process each line
$charts = $lines | ForEach-Object {
    # Split the line into parts
    $parts = $_ -split '\s+', 5
    if ($parts.Length -gt 1) {
        # Create a custom object with chart name and version
        [PSCustomObject]@{
            Name    = $parts[0]
            Version = $parts[1]
        }
    }
} | Where-Object { $_ -ne $null }

# Group by chart name
$groupedCharts = $charts | Group-Object -Property Name

# For each group, take the first two versions (0 and 1 indexes)
$groupedCharts | ForEach-Object {
    $chartName = $_.Name
    $versions = $_.Group | Select-Object -First 10
    $versions | ForEach-Object {
        # For demonstration, just printing out. You can replace this with `helm pull` command
        Write-Output "Chart: $chartName, Version: $($_.Version)"
        helm pull $chartName --version $_.Version
    }
}



########################################################################################################
########################################################################################################
########################################################################################################
########################################################################################################
