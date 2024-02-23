#!/bin/bash

# cd /opt/repo || { echo "Failed to change directory to /opt/repo";  }
# # Example usage:
# newName="webpacker,devise,mongo,redis,jq,jquery"
# fetch_gems "$newName"

# Function to fetch gems
# This function takes a comma-separated list of gem names and fetches the latest 10 versions of each gem
# It also fetches the dependencies of each gem and installs them in the /opt/repo directory
# The function uses a local associative array to hold unique gems to process
# The function uses a while loop to retry the search command in case of failure
# The function uses a for loop to iterate over each version of the gem and fetch it
# The function uses the gem dependency command to fetch and install the dependencies of each gem
# The function uses the gem fetch and gem install commands to fetch and install the gems
# The function uses the --source option to specify the gem source as http://
# The function uses the --install-dir option to specify the installation directory as /opt/repo
# The function uses the --version option to specify the version of the gem to fetch or install
# The function uses the --pipe option to pass the output of gem dependency to awk and grep commands
# The function uses the awk and grep commands to extract the gem names from the output of gem dependency
# The function uses the xargs command to pass the gem names to the gem fetch and gem install commands
# The function uses the IFS variable to set the Internal Field Separator to ',' and '()' for splitting strings into arrays
# The function uses the sort command to sort the versions of the gem in descending order and get the top 10 versions
# The function uses the read command to read the output of the sort command into an array
# The function uses the IFS variable to set the Internal Field Separator to ' ' for splitting strings into arrays
# The function uses the read command to read the output of the sort command into an array
# The function uses the array slicing syntax to get the top 10 versions of the gem
# The function uses the IFS variable to set the Internal Field Separator to ' ' for iterating over the top 10 versions
# The function uses the gem fetch and gem install commands to fetch and install the gems and their dependencies

function fetch_gems {
    local newName=$1
    cd /opt/repo || {
        echo "Failed to change directory to /opt/repo"
        return
    }

    # Convert comma-separated list of gem names into an array
    IFS=',' read -r -a gem_names <<<"$newName"

    # Use associative array to hold unique gems to process
    declare -A unique_gems

    # Loop through each gem name to search and collect unique results
    for gem_name in "${gem_names[@]}"; do
        echo "Searching for gem: $gem_name"
        local attempt=0
        local max_attempts=25
        local success=false

        while [ $attempt -lt $max_attempts ] && [ $success = false ]; do
            attempt=$((attempt + 1))
            echo "Attempt $attempt of $max_attempts for search command..."
            local search_results=$(gem search "^$gem_name$" --all) && success=true || echo "Search command failed for $gem_name. Waiting before retrying..."

            if [ $success = false ]; then
                sleep 1 # Wait for 1 second before retrying
            fi
        done

        if [ $success = false ]; then
            echo "Failed to complete the search command after $max_attempts attempts for $gem_name."
            continue # Skip to next gem name
        fi

        # echo "$search_results"
        echo "$gem_name search results: $search_results"

        # Processing the search results and fetching gems as before

        webpacker_line=$(echo "$search_results" | grep "^$(echo $gem_name) ") 
        # webpacker_line=$(echo "$search_results" | grep "^$(echo $gem_name) ") || { echo "Grep command failed";  }
        # webpacker_line=$(echo "$search_results" | grep "^$(echo $gem_name)") || { echo "Grep command failed";  }
        # webpacker_line=$(echo "$search_results" | grep "$(echo $gem_name)") || { echo "Grep command failed"; }

        # Split the line into an array, first field being the name and the second being the versions
        IFS='()'                                                                    # Internal Field Separator set to '()'
        read -ra ADDR <<<"$webpacker_line" || { echo "Failed to read into array"; } # The line is read into an array

        # Get packages as a first element of the array
        package=${ADDR[0]}

        # Get versions as a second element of the array
        versions=${ADDR[1]}

        # Replace commas with spaces to create an array of versions
        IFS=', ' read -r -a version_array <<<"$versions" || { echo "Failed to read versions into array"; }

        # Add the package and versions to the associative array
        # Sort versions in descending order and get the top 10
        IFS=$'\n' sorted_versions=($(sort -Vr <<<"${version_array[*]}"))
        IFS=' ' read -r -a top_10_versions <<<"${sorted_versions[@]:0:10}"

        # Iterate over each version in the array and fetch the gem
        # for version in "${version_array[@]}"; do
        for version in "${top_10_versions[@]}"; do
            local attempt1=0
            local attempt2=0
            local attempt3=0
            local max_attempts1=5
            local max_attempts2=5
            local max_attempts3=5
            local success1=false
            local success2=false
            local success3=false
            echo "Fetching $(echo $gem_name) version $version..."
            

            while [ $attempt1 -lt $max_attempts1 ] && [ $success1 = false ]; do
            attempt1=$((attempt1 + 1))
            echo "Attempt $attempt1 of $max_attempts1 for search command..."
            gem fetch $(echo $gem_name) -v "$version" --source http://127.0.0.1:9292 && $success1=true || {
                echo "Failed to fetch $(echo $gem_name) version $version"
                continue
            }

            if [ $success1 = false ]; then
                sleep 1 # Wait for 1 second before retrying
            fi
        done

        if [ $success1 = false ]; then
            echo "Failed to complete the search command after $max_attempts1 attempts for $gem_name."
            continue # Skip to next gem name
        fi

            
            


            while [ $attempt2 -lt $max_attempts2 ] && [ $success2 = false ]; do
            attempt2=$((attempt2 + 1))
            echo "Attempt $attempt2 of $max_attempts2 for search command..."
            gem dependency "$package" --version "$version" --pipe | awk -F " " '{print $1}' | grep -v "No" | xargs -i gem fetch {} --version "$version" --source http://127.0.0.1:9292 || {
                echo "Failed to fetch dependencies for version $version"
                continue
            }

            if [ $success2 = false ]; then
                sleep 1 # Wait for 1 second before retrying
            fi
        done

        if [ $success2 = false ]; then
            echo "Failed to complete the search command after $max_attempts1 attempts for $gem_name."
            continue # Skip to next gem name
        fi



            gem dependency "$package" --version "$version" --pipe | awk -F " " '{print $1}' | grep -v "No" | xargs -i gem install {} --version "$version" --install-dir /opt/repo --source http://127.0.0.1:9292 || {
                echo "Failed to install dependencies for version $version"
                continue
            }
        done

        echo "All versions of $(echo $gem_name) have been fetched."

    done

    echo "All unique gems have been processed."
}
