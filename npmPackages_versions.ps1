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
"@smui-extra/autocomplete"



$npmFilesSearched += $(97..122).foreach({npm search -p "@smui-extra/$([char]$_)"})

$npmFilesSearched += $files.foreach({npm search -p "$_"})


$npmFilesSearchedUnique = $($npmFilesSearched | sort | unique)
$npmFilesSearchedUnique = $($npmFilesSearchedUnique | sort | unique)
$npmFilesSearchedUnique = $($npmFilesSearchedUnique | sort | unique)
$npmFilesClean = $npmFilesSearchedUnique.foreach({ $($_.split("`t")[0]) })
foreach($file in $npmFilesClean){npm i "$file@latest" --legacy-peer-deps}
foreach($file in $npmFilesClean){npm i "$file@next" --legacy-peer-deps}
foreach($file in $npmFilesClean){$(0..10).foreach({npm i "$file@^$_" --legacy-peer-deps})}
foreach($file in $npmFilesClean){$(0..10).foreach({npm i "$file@~$_" --legacy-peer-deps})}



