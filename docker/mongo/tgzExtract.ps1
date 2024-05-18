# Directory containing the tgz files
$tgzDirectory = "D:\Transfer\node"
# Temporary extraction directory
$tempDirectory = "D:\Transfer\ToMove\build"


# MongoDB details
$mongoDb = "npm"
$mongoCollection = "depends"
$mongoConnectionString = "mongodb://localhost:27017"
$mongoimportPath = "D:\Transfer\mongodb\bin\mongoimport.exe"


# Ensure the temp directory exists
if (-Not (Test-Path $tempDirectory)) {
    New-Item -ItemType Directory -Path $tempDirectory | Out-Null
}

# Function to extract package.json from tgz file
function Extract-PackageJson {
    param (
        [string]$tgzFile,
        [string]$outputDirectory
    )

    # Extract tgz file using tar
    tar -xf $tgzFile -C $outputDirectory "package/package.json"

    # Return the path to the extracted package.json file
    return Get-ChildItem -Path $outputDirectory -Filter package.json -Recurse -File
}

# Iterate over all tgz files in the directory
Get-ChildItem -Path $tgzDirectory -Filter *.tgz | ForEach-Object {
    $tgzFile = $_.FullName
    $extractedFiles = Extract-PackageJson -tgzFile $tgzFile -outputDirectory $tempDirectory

    foreach ($packageJsonFile in $extractedFiles) {
        # Use mongoimport to insert the package.json content into MongoDB
        $mongoimportCommand = "& `"$mongoimportPath`" --uri=$mongoConnectionString --db=$mongoDb --collection=$mongoCollection --file=$($packageJsonFile.FullName) "
        Invoke-Expression $mongoimportCommand
    }

    # Clean up the temp directory for the next iteration
    Remove-Item -Path $tempDirectory\* -Recurse -Force
}

Write-Output "Import completed successfully."







