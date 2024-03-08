$files = "@smui/common",
"@smui/ripple",
"@smui/button",
"@smui/list",
"@smui/floating-label",
"@smui/menu-surface",
"@smui/textfield",
"@smui/icon-button",
"@smui/menu",
"@smui/notched-outline",
"@smui/line-ripple",
"@smui/dialog",
"@smui/select",
"@smui/checkbox",
"@smui/form-field",
"@smui/paper",
"@smui/top-app-bar",
"@smui/tab",
"@smui/tab-scroller",
"@smui/tab-indicator",
"@rollup/plugin-commonjs",
"@rollup/plugin",
"@rollup/plugin-node-resolve",
"@rollup/plugin-node",
"rollup",
"rollup-plugin-css-only",
"rollup-plugin-css",
"rollup-plugin-livereload",
"rollup-plugin-svelte",
"rollup-plugin-terser",
"rollup-plugin",
"svelte",
"@smui/common",
"@smui/linear-progress",
"sirv-cli",
"@playwright/test",
"@sveltejs/adapter-auto",
"@sveltejs/kit",
"@sveltejs",
"@types/cookie",
"eslint",
"eslint-config-prettier",
"eslint-config",
"eslint-plugin-svelte3",
"eslint-plugin",
"prettier",
"prettier-plugin-svelte",
"prettier-plugin",
"svelte",
"svelte-check",
"typescript",
"@fontsource/fira-mono",
"@fontsource",
"@lukeed/uuid",
"@lukeed",
"cookie",
"svelte",
"create-svelte",
"svelte-kit",
"@fanny-pack-ui/svelte-kit",
"svelte-kit-cookie-session",
"svelte-kit-cookie-session-patch",
"@sveltejs/kit",
"@sveltejs",
"esbuild-windows",
"esbuild",
"esbuild-linux",
"esbuild-",
"alpine",
"alpinejs",
"@alpine",
"@alpinejs",
"svelte-material-ui",
"svelte-material",
"smui-theme",
"@smui-extra/accordion",
"@smui-extra",
"@smui-extra/",
"@material/elevation",
"@material",
"@smui-extra/autocomplete",
"thiccclient-svelte",
"svelte-kit",
"svelte-check",
"@sveltejs/adapter-auto",
"@sveltejs/kit",
"autoprefixer",
"backendless",
"postcss",
"prettier",
"prettier-plugin-svelte",
"smui-theme",
"svelte",
"svelte-check",
"svelte-preprocess",
"tailwindcss",
"tslib",
"typescript",
"@sveltejs/adapter-node",
"daisyui"


$npmFilesSearched += $(97..122).foreach({npm search -p "@smui-extra/$([char]$_)"})
$npmFilesSearched += $(97..122).foreach({npm search -p "@daisyui/$([char]$_)"})

$npmFilesSearched += $files.foreach({npm search -p "$_"})


$npmFilesSearchedUnique = $($npmFilesSearched | sort | unique)
$npmFilesSearchedUnique = $($npmFilesSearchedUnique | sort | unique)
$npmFilesSearchedUnique = $($npmFilesSearchedUnique | sort | unique)
$npmFilesClean = $npmFilesSearchedUnique.foreach({ $($_.split("`t")[0]) })
# Search based on files found in previous search - expands on the limited results from the default npm search.
# $npmFilesSearched += $npmFilesClean.foreach({npm search -p "$_"})

foreach($file in $npmFilesClean){npm i "$file@latest" --legacy-peer-deps}
foreach($file in $npmFilesClean){npm i "$file@next" --legacy-peer-deps}
foreach($file in $npmFilesClean){$(0..10).foreach({npm i "$file@^$_" --legacy-peer-deps})}
foreach($file in $npmFilesClean){$(0..10).foreach({npm i "$file@~$_" --legacy-peer-deps})}





function Find-SimilarNpmNames {
    param (
        [string]$PackageName,
        [int]$Iterations
    )
    $npmFilesSearched += $PackageName.foreach({npm search -p "$_"})
    $npmFilesSearchedUnique = $($npmFilesSearched | Sort-Object | Get-Unique)
    $npmFilesSearchedUnique = $($npmFilesSearchedUnique | Sort-Object | Get-Unique)
    $npmFilesSearchedUnique = $($npmFilesSearchedUnique | Sort-Object | Get-Unique)
    $npmFilesClean = $npmFilesSearchedUnique.foreach({ $($_.split("`t")[0]) })
    if ($Iterations) {
        while ($Iterations -gt 1) {
            $Iterations -= 1
            # Search based on files found in previous search - expands on the limited results from the default npm search.
            $npmFilesSearched += $npmFilesClean.foreach({npm search -p "$_"})
            $npmFilesSearchedUnique = $($npmFilesSearched | Sort-Object | Get-Unique)
            $npmFilesSearchedUnique = $($npmFilesSearchedUnique | Sort-Object | Get-Unique)
            $npmFilesSearchedUnique = $($npmFilesSearchedUnique | Sort-Object | Get-Unique)
            $npmFilesClean = $npmFilesSearchedUnique.foreach({ $($_.split("`t")[0]) })
        }
    }
    return $npmFilesClean
}

function Install-NpmPackages {
    param (
        [string]$PackageName,
        [System.Collections.ArrayList]$PackageArray,
        [switch]$AllScoped,
        [switch]$AllLatest,
        [switch]$AllNext,
        [switch]$AllMajorVersions,
        [int]$UpperVersionRange,
        [int]$LowerVersionRange
    )
    # NOTES
    # If you see ~1.0.2 it means to install version 1.0.2 or the latest patch version such as 1.0.4. 
    # If you see ^1.0.2 it means to install version 1.0.2 or the latest minor or patch version such as 1.1.0.

    if (!$LowerVersionRange) {
        $LowerVersionRange = 0
    }
    if (!$UpperVersionRange) {
        $UpperVersionRange = 10
    }

    if ($AllScoped) {
        $PackageArray += $(97..122).foreach({npm search -p "$PackageName/$([char]$_)"})
    }
    if ($AllLatest) {
        if ($PackageArray) {
            foreach($PackageName in $PackageArray){npm i "$PackageName@latest" --legacy-peer-deps}
        } elseif ($PackageName) {
            npm i "$PackageName@latest" --legacy-peer-deps
        }else {
            Write-Host "PackageName OR PackageArray required with the AllLatest option."
        }
    }
    if ($AllNext) {
        if ($PackageArray) {
            foreach($PackageName in $PackageArray){npm i "$PackageName@next" --legacy-peer-deps}
        } elseif ($PackageName) {
            npm i "$PackageName@next" --legacy-peer-deps
        }else {
            Write-Host "PackageName OR PackageArray required with the AllNext option."
        }
    }
    if ($AllMajorVersions) {
        if ($PackageArray) {
            foreach($PackageName in $PackageArray){$($LowerVersionRange..$UpperVersionRange).foreach({npm i "$PackageName@^$_" --legacy-peer-deps})}    
        } elseif ($PackageName) {
            $($LowerVersionRange..$UpperVersionRange).foreach({npm i "$PackageName@^$_" --legacy-peer-deps})
        }else {
            Write-Host "PackageName OR PackageArray required with the AllMajorVersions option."
        }
        
    }
}
