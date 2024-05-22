#!/bin/bash

# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/vmware.txt"
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/react.txt"
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/svelte.txt"
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/packageLists/requests.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/packageLists/missingFiles.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/createapps.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/others.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/esbuild.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/bun.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/mantine.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/webpacker.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/rails.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/babel.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/vite.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/vitejs.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/nettest.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/typescript.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/kube.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/iconify.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/font-awesome.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/axios.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/dotenv.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/faye.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/gyp.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/misc.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/redux.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/swagger.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/vsphere.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/uiw.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/mdxeditor.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/rehyperemark.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/others/needsUpdates.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/others/g_test.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/requests/testing.txt" 
# SimpleNPMDownload -f "/root/TheRum/npmPackageFiles/TopLists/TopPackages20230227.txt" 

# SimpleNPMDownload -i "/root/tempnode" -f "/root/TheRum/npmPackageFiles\\svelte.txt"
# SimpleNPMDownload -i "/root/tempnode" -f "/root/TheRum/npmPackageFiles/packageLists/requests.txt" 

# SimpleNPMDownload -d "/root/TheRum/npmPackageFiles/requests"
# SimpleNPMDownload -d "/root/TheRum/npmPackageFiles/others"
# SimpleNPMDownload -d "/root/TheRum/npmPackageFiles/TopLists"
# SimpleNPMDownload -d "/root/TheRum/npmPackageFiles/packageLists"

# $(SimpleNPMDownload -d "/root/TheRum/npmPackageFiles/requests" & ) &

# SimpleNPMDownload -f "/path/to/packageList.txt" -d "/path/to/directoryOfPackageLists" -i "/path/to/installDirectory" -r "http://127.0.0.1:4873/"
# IT FINALLY WORKS!!!!!!!!!! IT WAS A HIDDEN RETURN CHARACTER IN THE TEXT FILES!!!!!!!!!!!!


function SimpleNPMDownload() {
    local InstallDirectory="/root/tempnode"
    local Registry="http://192.168.0.40:4873/"
    local PackageListTxtFile=""
    local DirectoryOfPackageListTxtFiles=""

    # Parse named arguments
    while getopts ":f:d:i:r:" opt; do
        case $opt in
            f) PackageListTxtFile="$OPTARG" ;;
            d) DirectoryOfPackageListTxtFiles="$OPTARG" ;;
            i) InstallDirectory="$OPTARG" ;;
            r) Registry="$OPTARG" ;;
            \?) echo "Invalid option -$OPTARG" >&2; return 1 ;;
            :) echo "Option -$OPTARG requires an argument." >&2; return 1 ;;
        esac
    done
    shift $((OPTIND-1))

    local txtfiles=()

    if [ -n "$PackageListTxtFile" ]; then
        txtfiles=("$PackageListTxtFile")
    elif [ -n "$DirectoryOfPackageListTxtFiles" ]; then
        readarray -t txtfiles < <(find "$DirectoryOfPackageListTxtFiles" -maxdepth 1 -type f)
    fi

    if [ ${#txtfiles[@]} -eq 0 ]; then
        echo "Must provide a package list file or a directory of text files." >&2
        return 1
    fi

    echo "Number of txtfiles: ${#txtfiles[@]}"
    echo "Text Files: ${txtfiles[*]}"

    InstallDirectory="${InstallDirectory%/}"
    mkdir -p "$InstallDirectory" || { echo "Could not create directory $InstallDirectory"; return 1; }
    cd "$InstallDirectory" || { echo "Failed to change directory"; return 1; }

    unclean_packages=$(cat "${txtfiles[@]}" | tr '\\' '/' | sed 's/[^a-zA-Z0-9@/-]//g')
    clean_packages=$(echo "$unclean_packages" | sort -u)

    echo "In the correct directory: $(pwd)"

    # Prepare npm install function
    npm_install() {
        local package=$1
        echo "Downloading $package..."
        local random=$(shuf -i 100000-999999 -n 1)
        local temp_dir="$InstallDirectory/$random"
        mkdir -p "$temp_dir"

        if [ ! -d "$temp_dir" ]; then
            echo "Directory creation failed: $temp_dir" >&2
            return 1
        fi

        pushd "$temp_dir" > /dev/null 2>&1
        npm install "$package@latest" --force --registry "$Registry" --prefix "$temp_dir" &&
        rm -rf "$temp_dir/node_modules" &&
        npm install "$package" --force --registry "$Registry" --prefix "$temp_dir" && {
            npm audit fix --registry "$Registry"
            npm audit fix --force --registry "$Registry"
        }
        popd > /dev/null 2>&1

        rm -rf "$temp_dir"
    }

    export -f npm_install
    export InstallDirectory
    export Registry

    # Use xargs to run npm installations in parallel
    echo "$clean_packages" | xargs -P 10 -I {} bash -c 'npm_install "$@"' _ {}

    # Unset exported functions and variables
    unset -f npm_install
    # unset InstallDirectory Registry PackageListTxtFile DirectoryOfPackageListTxtFiles
    unset PackageListTxtFile DirectoryOfPackageListTxtFiles InstallDirectory Registry txtfiles clean_packages unclean_packages
}

# Example usage
# SimpleNPMDownload -f "/path/to/packageList.txt" -d "/path/to/directoryOfPackageLists" -i "/path/to/installDirectory" -r "http://192.168.0.40:4873/"







# function SimpleNPMDownload() {
#     local InstallDirectory="/root/tempnode"
#     local Registry="http://192.168.0.40:4873/"
#     local PackageListTxtFile=""
#     local DirectoryOfPackageListTxtFiles=""

#     # Parse named arguments
#     while getopts ":f:d:i:r:" opt; do
#         case $opt in
#             f) PackageListTxtFile="$OPTARG" ;;
#             d) DirectoryOfPackageListTxtFiles="$OPTARG" ;;
#             i) InstallDirectory="$OPTARG" ;;
#             r) Registry="$OPTARG" ;;
#             \?) echo "Invalid option -$OPTARG" >&2; return 1 ;;
#             :) echo "Option -$OPTARG requires an argument." >&2; return 1 ;;
#         esac
#     done
#     shift $((OPTIND-1))

#     local txtfiles=()

#     if [ -n "$PackageListTxtFile" ]; then
#         txtfiles=("$PackageListTxtFile")
#     elif [ -n "$DirectoryOfPackageListTxtFiles" ]; then
#         # Make sure to read all files and filter out directories
#         readarray -t txtfiles < <(find "$DirectoryOfPackageListTxtFiles" -maxdepth 1 -type f)
#     fi

#     if [ ${#txtfiles[@]} -eq 0 ]; then
#         echo "Must provide a package list file or a directory of text files." >&2
#         return 1
#     fi

#     echo "Number of txtfiles: ${#txtfiles[@]}"
#     echo "Text Files: ${txtfiles[*]}"

#     InstallDirectory="${InstallDirectory%/}"
#     mkdir -p "$InstallDirectory" || { echo "Could not create directory $InstallDirectory"; return 1; }
#     cd "$InstallDirectory" || { echo "Failed to change directory"; return 1; }

#     unclean_packages=$(cat "${txtfiles[@]}" | tr '\\' '/' | sed 's/[^a-zA-Z0-9@/-]//g')
#     clean_packages=$(echo "$unclean_packages" | sort -u)

#     echo "In the correct directory: $(pwd)"

#     for package in $clean_packages; do
#         echo "Downloading $package..."
#         local random=$(shuf -i 100000-999999 -n 1)
#         local temp_dir="$InstallDirectory/$random"
#         mkdir -p "$temp_dir"

#         if [ ! -d "$temp_dir" ]; then
#             echo "Directory creation failed: $temp_dir" >&2
#             continue
#         fi

#         pushd "$temp_dir" > /dev/null 2>&1
#         npm install "$package@latest" --force --registry "$Registry" --prefix "$temp_dir" &&
#         rm -rf "$temp_dir/node_modules" &&
#         npm install "$package" --force --registry "$Registry" --prefix "$temp_dir" || {
#             echo "Failed to install $package" >&2
#         }
#         npm audit fix --registry "$Registry"
#         npm audit fix --force --registry "$Registry"
#         popd > /dev/null 2>&1

#         rm -rf "$temp_dir"
#     done

#     # Unset variables
#     unset PackageListTxtFile DirectoryOfPackageListTxtFiles InstallDirectory Registry txtfiles clean_packages unclean_packages
# }







# #!/bin/bash

# function SimpleNPMDownload() {
#     # Default values
#     # PackageListTxtFile=""
#     # DirectoryOfPackageListTxtFiles=""
#     InstallDirectory="/root/tempnode"
#     Registry="http://192.168.0.40:4873/"

#     # Parse named arguments
#     while getopts ":f:d:i:r:" opt; do
#         case $opt in
#             f) PackageListTxtFile="$OPTARG" ;;
#             d) DirectoryOfPackageListTxtFiles="$OPTARG" ;;
#             i) InstallDirectory="$OPTARG" ;;
#             r) Registry="$OPTARG" ;;
#             \?) echo "Invalid option -$OPTARG" >&2; return 1 ;;
#             :) echo "Option -$OPTARG requires an argument." >&2; return 1 ;;
#         esac
#     done

#     txtfiles=()

#     if [ -n "$PackageListTxtFile" ]; then
#         txtfiles=("$PackageListTxtFile")
#     elif [ -n "$DirectoryOfPackageListTxtFiles" ]; then
#         txtfiles=("$DirectoryOfPackageListTxtFiles"/*)
#     else
#         echo "Must provide a package list file or a directory of text files." >&2
#         return 1
#     fi

#     echo "Number of txtfiles: ${#txtfiles[@]}"
#     echo "Text Files: ${txtfiles[*]}"

#     InstallDirectory="${InstallDirectory%/}"
#     mkdir -p "$InstallDirectory" || { echo "Could not create directory $InstallDirectory"; return 1; }
#     cd "$InstallDirectory" || { echo "Failed to change directory"; return 1; }

#     unclean_packages=$(cat "${txtfiles[@]}" | tr '\\' '/' | sed 's/[^a-zA-Z0-9@/-]//g')
#     clean_packages=$(echo "$unclean_packages" | sort -u)

#     echo "In the correct directory: $(pwd)"

#     for package in $clean_packages; do
#         echo "Downloading $package..."
#         random=$(shuf -i 100000-999999 -n 1)
#         temp_dir="$InstallDirectory/$random"
#         mkdir -p "$temp_dir"

#         if [ ! -d "$temp_dir" ]; then
#             echo "Directory creation failed: $temp_dir" >&2
#             continue
#         fi

#         pushd "$temp_dir" > /dev/null 2>&1
#         npm install "$package@latest" --force --registry "$Registry" --prefix "$temp_dir" &&
#         rm -rf "$temp_dir/node_modules" &&
#         npm install "$package" --force --registry "$Registry" --prefix "$temp_dir" || {
#             echo "Failed to install $package" >&2
#         }
#         npm audit fix --registry "$Registry"
#         npm audit fix --force --registry "$Registry"
#         popd > /dev/null 2>&1

#         rm -rf "$temp_dir"
#     done
# }


# # Example usage
# # SimpleNPMDownload -f "/path/to/packageList.txt" -d "/path/to/directoryOfPackageLists" -i "/path/to/installDirectory" -r "http://127.0.0.1:4873/"




# # #!/bin/bash

# # function SimpleNPMDownload() {
# #     # Default values
# #     InstallDirectory="/root/tempnode"
# #     Registry="http://127.0.0.1:4873/"

# #     # Parse named arguments
# #     while getopts ":f:d:i:r:" opt; do
# #         case $opt in
# #             f) PackageListTxtFile="$OPTARG" ;;
# #             d) DirectoryOfPackageListTxtFiles="$OPTARG" ;;
# #             i) InstallDirectory="$OPTARG" ;;
# #             r) Registry="$OPTARG" ;;
# #             \?) echo "Invalid option -$OPTARG" >&2; return 1 ;;
# #             :) echo "Option -$OPTARG requires an argument." >&2; return 1 ;;
# #         esac
# #     done

# #     txtfiles=()

# #     # Get package files
# #     if [ -n "$PackageListTxtFile" ]; then
# #         txtfiles=("$PackageListTxtFile")
# #     elif [ -n "$DirectoryOfPackageListTxtFiles" ]; then
# #         txtfiles=("$DirectoryOfPackageListTxtFiles"/*)
# #     else
# #         echo "Must provide a package list file or a directory of text files." >&2
# #         return 1
# #     fi

# #     echo "Number of txtfiles: ${#txtfiles[@]}"
# #     echo "Text Files: ${txtfiles[*]}"

# #     # Set install directory, trim trailing slashes
# #     InstallDirectory="${InstallDirectory%/}"

# #     mkdir -p "$InstallDirectory" || { echo "Could not create directory $InstallDirectory"; return 1; }

# #     # Change to install directory
# #     cd "$InstallDirectory" || { echo "Failed to change directory"; return 1; }

# #     # Read all files, clean package names, and remove duplicates
# #     unclean_packages=$(cat "${txtfiles[@]}" | tr '\\' '/' | sed 's/[^a-zA-Z0-9-@/]//g')
# #     clean_packages=$(echo "$unclean_packages" | sort -u)

# #     echo "In the correct directory: $(pwd)"

# #     # Loop through packages and download them
# #     for package in $clean_packages; do
# #         echo "Downloading $package..."
# #         random=$(shuf -i 100000-999999 -n 1)
# #         temp_dir="$InstallDirectory/$random"
# #         mkdir -p "$temp_dir"

# #         if [ ! -d "$temp_dir" ]; then
# #             echo "Directory creation failed: $temp_dir" >&2
# #             continue
# #         fi

# #         echo "Creating directory: $temp_dir"
# #         mkdir -p "$temp_dir" && echo "Directory created successfully."

# #         # Optional: Adding a brief sleep to handle any file system delays
# #         sleep 1

# #         pushd "$temp_dir" > /dev/null 2>&1
# #         echo "Current directory: $(pwd)"
# #         npm install "$package@latest" --force --registry "$Registry" --prefix "$temp_dir" &&
# #         rm -rf "$temp_dir/node_modules" &&
# #         npm install "$package" --force --registry "$Registry" --prefix "$temp_dir" || {
# #             echo "Failed to install $package" >&2
# #         }
# #         npm audit fix --registry "$Registry"
# #         npm audit fix --force --registry "$Registry"
# #         popd > /dev/null 2>&1

# #         # Remove temporary directory
# #         rm -rf "$temp_dir"
# #     done
# # }

# # # Example usage
# # # SimpleNPMDownload -f "/path/to/packageList.txt" -d "/path/to/directoryOfPackageLists" -i "/path/to/installDirectory" -r "http://127.0.0.1:4873/"




# # # #!/bin/bash

# # # function SimpleNPMDownload() {
# # #     # Default values
# # #     InstallDirectory='/root/tempnode'
# # #     Registry='http://127.0.0.1:4873'

# # #     # Parse named arguments
# # #     while getopts ":f:d:i:r:" opt; do
# # #         case $opt in
# # #             f) PackageListTxtFile="$OPTARG" ;;
# # #             d) DirectoryOfPackageListTxtFiles="$OPTARG" ;;
# # #             i) InstallDirectory="$OPTARG" ;;
# # #             r) Registry="$OPTARG" ;;
# # #             \?) echo "Invalid option -$OPTARG" >&2; return 1 ;;
# # #             :) echo "Option -$OPTARG requires an argument." >&2; return 1 ;;
# # #         esac
# # #     done

# # #     txtfiles=()

# # #     # Get package files
# # #     if [ -n "$PackageListTxtFile" ]; then
# # #         txtfiles=("$PackageListTxtFile")
# # #     elif [ -n "$DirectoryOfPackageListTxtFiles" ]; then
# # #         txtfiles=("$DirectoryOfPackageListTxtFiles"/*)
# # #     else
# # #         echo "Must provide a package list file or a directory of text files." >&2
# # #         return 1
# # #     fi

# # #     echo "Number of txtfiles: ${#txtfiles[@]}"
# # #     echo "Text Files: ${txtfiles[*]}"

# # #     # Set install directory, trim trailing slashes
# # #     InstallDirectory="${InstallDirectory%/}"

# # #     mkdir -p "$InstallDirectory" || { echo "Could not create directory $InstallDirectory"; return 1; }

# # #     # Change to install directory
# # #     cd "$InstallDirectory" || { echo "Failed to change directory"; return 1; }

# # #     # Read all files and remove duplicates
# # #     unclean_packages=$(cat "${txtfiles[@]}" | tr '\\' '/')
# # #     clean_packages=$(echo "$unclean_packages" | sort -u)

# # #     echo "In the correct directory: $(pwd)"

# # #     # Loop through packages and download them
# # #     for package in $clean_packages; do
# # #         echo "Downloading $package..."
# # #         random=$(shuf -i 100000-999999 -n 1)
# # #         temp_dir="$InstallDirectory/$random"
# # #         mkdir -p "$temp_dir"

# # #         if [ ! -d "$temp_dir" ]; then
# # #             echo "Directory creation failed: $temp_dir" >&2
# # #             continue
# # #         fi

# # #         # pushd "$temp_dir" > /dev/null 2>&1
# # #         # cd "$temp_dir"
# # #         # npm install "$package@latest" --force --registry "$Registry" --prefix "$temp_dir" &&
# # #         # rm -rf "$temp_dir/node_modules" &&
# # #         echo "$package"
# # #         echo "$Registry"
# # #         echo "npm install $package --force --registry $Registry "
# # #         # sleep 2
# # #         npm install "$package" --force --registry "$Registry" --prefix "$temp_dir" || {
# # #             echo "Failed to install $package" >&2
# # #         }
# # #         npm audit fix --registry "$Registry"
# # #         npm audit fix --force --registry "$Registry"
# # #         # popd > /dev/null 2>&1
# # #         # cd $InstallDirectory

# # #         # Remove temporary directory
# # #         rm -rf "$temp_dir"
# # #     done
# # # }

# # # Example usage
# # # SimpleNPMDownload -f "/path/to/packageList.txt" -d "/path/to/directoryOfPackageLists" -i "/path/to/installDirectory" -r "http://127.0.0.1:4873/"


# # # for package in $(cat "/root/TheRum/npmPackageFiles/requests/vitejs.txt" ); do
# # #     echo "Downloading $package..."
# # #     /usr/local/bin/npm i "$(echo $package)"  
# # # done


# # # #!/bin/bash

# # # function SimpleNPMDownload() {
# # #     npmPackageList="$1"
# # #     PackageListTxtFile="$2"
# # #     DirectoryOfPackageListTxtFiles="$3"
# # #     InstallDirectory="${4:-/root/tempnode/}"
# # #     Registry="${5:-http://127.0.0.1:4873/}"
# # #     txtfiles=()

# # #     # Get package files
# # #     if [ -n "$PackageListTxtFile" ]; then
# # #         txtfiles=("$PackageListTxtFile")
# # #     elif [ -n "$DirectoryOfPackageListTxtFiles" ]; then
# # #         txtfiles=("$DirectoryOfPackageListTxtFiles"/*)
# # #     else
# # #         echo "Must provide a package list file or a directory of text files." >&2
# # #         return 1
# # #     fi

# # #     echo "Number of txtfiles: ${#txtfiles[@]}"
# # #     echo "Text Files: ${txtfiles[*]}"

# # #     # Set install directory, trim trailing slashes
# # #     InstallDirectory="${InstallDirectory%/}"

# # #     mkdir -p "$InstallDirectory" || { echo "Could not create directory $InstallDirectory"; return 1; }

# # #     # Change to install directory
# # #     cd "$InstallDirectory" || { echo "Failed to change directory"; return 1; }

# # #     # Read all files and remove duplicates
# # #     unclean_packages=$(cat "${txtfiles[@]}" | tr '\\' '/')
# # #     clean_packages=$(echo "$unclean_packages" | sort -u)

# # #     echo "In the correct directory: $(pwd)"

# # #     # Loop through packages and download them
# # #     for package in $clean_packages; do
# # #         echo "Downloading $package..."
# # #         random=$(shuf -i 100000-999999 -n 1)
# # #         temp_dir="$InstallDirectory/$random"
# # #         mkdir -p "$temp_dir"

# # #         if [ ! -d "$temp_dir" ]; then
# # #             echo "Directory creation failed: $temp_dir" >&2
# # #             continue
# # #         fi
        
# # #         echo "changing directory to $temp_dir"

# # #         pushd "$temp_dir" > /dev/null 2>&1
# # #         # npm install "$package@latest" --force --registry "$Registry" --prefix "$temp_dir" &&
# # #         # rm -rf "$temp_dir/node_modules" &&
# # #         # npm install "$package" --force --registry "$Registry" --prefix "$temp_dir" || {
# # #         # npm install "$package" --force --registry "$Registry"  || {
# # #         # npm install "$package" --force --registry "http://127.0.0.1:4873/" --prefix "$temp_dir" || {
# # #         # echo " npm install --force --registry "http://127.0.0.1:4873/" "${package}" "
# # #          npm install --force --registry http://127.0.0.1:4873/ ${package}  || {
# # #             echo "Failed to install $package" >&2
# # #         }
# # #         npm audit fix --registry "$Registry"
# # #         npm audit fix --force --registry "$Registry"
# # #         popd > /dev/null 2>&1

# # #         # Remove temporary directory
# # #         rm -rf "$temp_dir"
# # #     done
# # # }


























# # # # function SimpleNPMDownload() {
# # # #     npmPackageList="$1"
# # # #     PackageListTxtFile="$2"
# # # #     DirectoryOfPackageListTxtFiles="$3"
# # # #     InstallDirectory="${4:-/root/tempnode/}"
# # # #     Registry="${5:-http://127.0.0.1:4873/}"
# # # #     txtfiles=()
    
# # # #     # Get package files
# # # #     if [ -n "$PackageListTxtFile" ]; then
# # # #         txtfiles=("$PackageListTxtFile")
# # # #     elif [ -n "$DirectoryOfPackageListTxtFiles" ]; then
# # # #         txtfiles=("$DirectoryOfPackageListTxtFiles"/*)
# # # #     else
# # # #         echo "Must provide a package list file or a directory of text files." >&2
# # # #         return 1
# # # #     fi

# # # #     echo "Number of txtfiles: ${#txtfiles[@]}"
# # # #     echo "Text Files: ${txtfiles[*]}"

# # # #     # Set install directory, trim trailing slashes
# # # #     InstallDirectory="${InstallDirectory%/}"

# # # #     mkdir -p "$InstallDirectory" || { echo "Could not create directory $InstallDirectory"; return 1; }

# # # #     # Change to install directory
# # # #     cd "$InstallDirectory" || { echo "Failed to change directory"; return 1; }

# # # #     # Read all files and remove duplicates
# # # #     unclean_packages=$(cat "${txtfiles[@]}" | tr '\\' '/')
# # # #     # Print out first 10 in the unclean packages
# # # #     echo "Unclean Packages: $unclean_packages"| head -n 11
# # # #     clean_packages=$(echo "$unclean_packages" | sort -u)

# # # #     # Print out first 10 in the unclean packages
# # # #     echo "Clean Packages: $clean_packages"| head -n 11

# # # #     echo "In the correct directory: $(pwd)"

# # # #     # Loop through packages and download them
# # # #     for package in $clean_packages; do
# # # #         echo "Downloading $package..."
# # # #         random=$(shuf -i 100000-999999 -n 1)
# # # #         temp_dir="$InstallDirectory/$random"
# # # #         mkdir -p "$temp_dir"

# # # #         if [ ! -d "$temp_dir" ]; then
# # # #             mkdir -p "$temp_dir"
# # # #         fi
# # # #         {
# # # #             echo "Installing $package into $temp_dir..."
# # # #             npm install "$package" --force --registry "$Registry" --prefix "$temp_dir"
# # # #         # } || {
# # # #         #     echo "Failed to install $package"
# # # #         }

# # # #         # Perform npm audit fix
# # # #         # cd "$temp_dir" || continue
# # # #         cd "$temp_dir" || { echo "Failed to change directory"; return 1; }
# # # #         npm audit fix --registry "$Registry"
# # # #         npm audit fix --force --registry "$Registry"
# # # #         cd "$InstallDirectory"

# # # #         # Remove temporary directory
# # # #         rm -rf "$temp_dir"
# # # #     done
# # # # }
