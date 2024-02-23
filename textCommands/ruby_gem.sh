


# ----------------------------------------------------------------------------------------------------------------------------



###############################

#! All Versions of a Gem
#? 20240211 - This one is the best one so far.
#? Narrows the search to the searchterm and its versions
#? Limits the versions to the top 10 newest versions

#!/bin/bash



newName="hoe,react,mysql2,pg,sqlite3,tzinfo,capistrano,sassc,rails,mongo,jquery,redis,devise,sidekiq,rspec,carrierwave,bootstrap,haml,devise,omniauth,activeadmin,ldap"
# newName="hoe,pg,mongo,jquery,redis"
# newName="pg,mongo,jquery,redis"
# newName="react,mysql2,sqlite3,tzinfo,capistrano,sass,rails,mongo,bootstrap,haml,devise"
# newName="gemstash,gemirro,geminabox,aruba,guard-minitest,citrus,webrick,mustache"
# newName="server_health_check-rack,server_health_check,gemstash,gemirro,geminabox,puma"
# newName="babel"
# newName="pry"
# newName="pry-byebug"
# newName="psych"
# newName="rake-compiler"
# newName="bcrypt"
# newName="openssl"
# newName="ldap"
# newName="rdoc"
# newName="rails"
# newName="faye"
# newName="gemstash"
# newName="server_health_check"
# newName="mysql2"
# newName="postgres"
# newName="mongo"
# newName="pry,pry-byebug,webpacker,rake-compiler,rake,rspec,rspec-core,rspec-support,rspec-expectations,json,faye"
# newName="pry,pry-byebug,webpacker,rake-compiler,rake,rspec,rspec-core,rspec-support,rspec-expectations,coderay,mocha,simplecov-html,docile,json"
# newName="server_health_check-rack,server_health_check,gemstash,gemirro,geminabox,webpacker,devise,mongo,redis,jq,jquery"
# newName="pry,pry-byebug,webpacker,babel-plugin-macros,case-sensitive-paths-webpack,core-js,regenerator-runtime,faye,solargraph,goldiloader,puma,geminabox,gemstash,gemirro,aruba,guard-minitest,citrus,webrick,mustache,dalli,faraday,faraday_middleware,lru_redux,psych,sinatra,sequel,server_health_check-rack,server_health_check,terminal-table,thor,sqlite3,activesupport,nio4r,jumbled-rspec-formatter,simplecov_json_formatter,rake-compiler,rspec,rspec-core,rspec-support,rspec-expectations,coderay,mocha,simplecov-html,docile,json"

cd /opt/repo || { echo "Failed to change directory to /opt/repo";  }

# Convert comma-separated list of gem names into an array
IFS=',' read -r -a gem_names <<< "$newName"

# Use associative array to hold unique gems to process
declare -A unique_gems

# Loop through each gem name to search and collect unique results
for gem_name in "${gem_names[@]}"; do
    echo "Searching for gem: $gem_name"
    attempt=0
    max_attempts=25
    success=false
    # Initialize attempt counter
    while [ $attempt -lt $max_attempts ] && [ $success = false ]; do
        attempt=$((attempt + 1))
        echo "Attempt $attempt of $max_attempts for search command..."
        search_results=$(gem search "^$gem_name$" --all) && success=true || echo "Search command failed for $gem_name. Waiting before retrying..."
        
        if [ $success = false ]; then
            sleep 1 # Wait for 1 second before retrying
        fi
    done

    if [ $success = false ]; then
        echo "Failed to complete the search command after $max_attempts attempts for $gem_name."
        continue # Skip to next gem name
    fi

    echo "$search_results"

    webpacker_line=$(echo "$search_results" | grep "^$(echo $gem_name) ") || { echo "Grep command failed";  }

    # Split the line into an array, first field being the name and the second being the versions
    IFS='()' # Internal Field Separator set to '()'
    read -ra ADDR <<< "$webpacker_line" || { echo "Failed to read into array"; } # The line is read into an array

    # Get packages as a first element of the array
    package=${ADDR[0]}

    # Get versions as a second element of the array
    versions=${ADDR[1]}

    # Replace commas with spaces to create an array of versions
    IFS=', ' read -r -a version_array <<< "$versions" || { echo "Failed to read versions into array";  }

    # Add the package and versions to the associative array
    # Sort versions in descending order and get the top 10
    IFS=$'\n' sorted_versions=($(sort -Vr <<<"${version_array[*]}"))
    IFS=' ' read -r -a top_10_versions <<< "${sorted_versions[@]:0:10}"


    # Iterate over each version in the array and fetch the gem
    # for version in "${version_array[@]}"; do
    for version in "${top_10_versions[@]}"; do
        echo "Fetching $(echo $gem_name) version $version..."
        gem fetch $(echo $gem_name) -v "$version" --source http://127.0.0.1:9292 || { echo "Failed to fetch $(echo $gem_name) version $version"; continue; }
        gem dependency "$package" --version "$version" --pipe | awk -F " "  '{print $1}' | grep -v "No" | xargs -i gem fetch {} --version "$version" --source http://127.0.0.1:9292 || { echo "Failed to fetch dependencies for version $version"; continue; }
        gem dependency "$package" --version "$version" --pipe | awk -F " "  '{print $1}' | grep -v "No" | xargs -i gem install {} --version "$version" --install-dir /opt/repo --source http://127.0.0.1:9292 || { echo "Failed to install dependencies for version $version"; continue; }
    done

    echo "All versions of $(echo $gem_name) have been fetched."

done








# ----------------------------------------------------------------------------------------------------------------------------
# # apt update -y
# # apt install -y parallel

# gem sources -r https://rubygems.org/
# # gem sources -a http://127.0.0.1:9292
# gem sources -a http://172.20.0.9:9292

# # newName="hoe,react,mysql2,pg,sqlite3,tzinfo,capistrano,sass,rails,mongo,jquery,redis,devise,sidekiq,rspec,carrierwave,bootstrap,haml,devise,omniauth,activeadmin,ldap"
# # newName="hoe,pg,mongo,jquery,redis"
# # newName="react,mysql2,sqlite3,tzinfo,capistrano,sass,rails,mongo,bootstrap,haml,devise"
# # newName="gemstash,gemirro,geminabox,aruba,guard-minitest,citrus,webrick,mustache"
# # newName="server_health_check-rack,server_health_check,gemstash,gemirro,geminabox,puma"
# # newName="babel"
# # newName="pry"
# # newName="pry-byebug"
# # newName="psych"
# # newName="rake-compiler"
# # newName="bcrypt"
# # newName="openssl"
# # newName="ldap"
# # newName="rdoc"
# # newName="rails"
# # newName="faye"
# # newName="gemstash"
# # newName="server_health_check"
# # newName="mysql2"
# # newName="postgres"
# # newName="mongo"
# # newName="pry,pry-byebug,webpacker,rake-compiler,rake,rspec,rspec-core,rspec-support,rspec-expectations,json,faye"
# # newName="pry,pry-byebug,webpacker,rake-compiler,rake,rspec,rspec-core,rspec-support,rspec-expectations,coderay,mocha,simplecov-html,docile,json"
# # newName="server_health_check-rack,server_health_check,gemstash,gemirro,geminabox,webpacker,devise,mongo,redis,jq,jquery"
# # newName="pry,pry-byebug,webpacker,babel-plugin-macros,case-sensitive-paths-webpack,core-js,regenerator-runtime,faye,solargraph,goldiloader,puma,geminabox,gemstash,gemirro,aruba,guard-minitest,citrus,webrick,mustache,dalli,faraday,faraday_middleware,lru_redux,psych,sinatra,sequel,server_health_check-rack,server_health_check,terminal-table,thor,sqlite3,activesupport,nio4r,jumbled-rspec-formatter,simplecov_json_formatter,rake-compiler,rspec,rspec-core,rspec-support,rspec-expectations,coderay,mocha,simplecov-html,docile,json"

# cd /opt/repo/

# echo "" > files

# for j in $(echo $newName | tr "," "\n")
#     do gem search "$j" >> files
# done

# for i in $(cat files | awk -F " "  '{print $1}' | sort -u)
#     do gem fetch "$i" --source http://172.20.0.9:9292
#     # do gem fetch "$i" 
#     # gem install "$i" --source http://127.0.0.1:9292 --development-all
#     # gem install "$i" --development-all
#     # gem dependency "$i" --pipe | awk -F " "  '{print $1}' | grep -v "No" | xargs -i gem install {} --install-dir /opt/repo --source http://127.0.0.1:9292 --development-all
#     # gem dependency "$i" --pipe | awk -F " "  '{print $1}' | grep -v "No" | xargs -i gem install {} --install-dir /opt/repo --development-all
#     gem dependency "$i" --pipe | awk -F " "  '{print $1}' | grep -v "No" | xargs -i gem fetch {} --source http://172.20.0.9:9292
# done


# ----------------------------------------------------------------------------------------------------------------------------
# apt update -y
# apt install -y parallel

# # Works!!!
# SEARCTERM='pry'
# # SEARCTERM='pry-byebug'

# for i in $(gem search "$SEARCHTERM" | awk -F " "  '{print $1}')
#     do gem fetch "$i"  
#     gem dependency "$i" --pipe | awk -F " "  '{print $1}' | grep -v "No" | parallel gem fetch 
# done

# ----------------------------------------------------------------------------------------------------------------------------

#! Get NEWEST version of a gem!!!!!!
# Downloading all the versions from a search

#!/bin/bash

searchterm='mysql2'
# searchterm='pry'
# searchterm='pry-byebug'
# searchterm='rails'
# searchterm='webpacker'
# searchterm='bootsnap'
# searchterm='bootstrap'
# searchterm='ldap3'
# searchterm='rubocop'
# searchterm='capistrano'
# searchterm='react'
# searchterm='rbvmomi'
# searchterm='sass'
# searchterm='sassc'
# searchterm='babel'
# searchterm='openssl'
# searchterm='sassc'
# searchterm='turbo'
# searchterm='stimulus'
# searchterm='strata'
# searchterm='faye'
# searchterm='solargraph'

# searchterm='webpacker'
# searchterm='babel-plugin-macros'
# searchterm='case-sensitive-paths-webpack-plugin'
# searchterm='core-js'
# searchterm='regenerator-runtime'
# searchterm='goldiloader'
# searchterm='puma'
# searchterm='rake'
# searchterm='rake-compiler'
# searchterm='server_health_check'

cd /opt/repo/

# Search for the webpacker gem and store the output in a variable
search_results=$(gem search $(echo $searchterm) --all)

# Read each line of the search results
while IFS= read -r line; do
    # Use a regex to match the package name and capture all version numbers in a group
    if [[ $line =~ ^([a-z0-9_-]+)\ \((.+)\)$ ]]; then
        package="${BASH_REMATCH[1]}"
        versions="${BASH_REMATCH[2]}"
      
        # Replace commas with spaces to create an array of versions
        IFS=', ' read -r -a version_array <<< "$versions"

        # Download the gem for the package
        # gem install -f "$package" --install-dir /opt/repo --source http://localhost:9292 
        # gem install "$package" --install-dir /opt/repo 
        # gem fetch "$package" --install-dir /opt/repo --source http://172.20.0.9:9292
        gem fetch "$package" --source http://localhost:9292
        # gem dependency "$package" --pipe | awk -F " "  '{print $1}' | grep -v "No" | xargs -i gem fetch {} --source http://172.20.0.9:9292
        gem dependency "$package" --pipe | awk -F " "  '{print $1}' | grep -v "No" | xargs -i gem fetch {} --source http://localhost:9292
    fi
done <<< "$search_results"

echo "All $(echo $searchterm) packages and versions have been fetched."



# ----------------------------------------------------------------------------------------------------------------------------

#! Get TOP 3 versions of a gem!!!!!!
# Downloading 3 versions from a search

#!/bin/bash

searchterm='mysql2'
# searchterm='pry'
# searchterm='pry-byebug'
# searchterm='rails'
# searchterm='webpacker'
# searchterm='bootsnap'
# searchterm='bootstrap'
# searchterm='ldap3'
# searchterm='rubocop'
# searchterm='capistrano'
# searchterm='react'
# searchterm='rbvmomi'
# searchterm='sassc'
# searchterm='babel'
# searchterm='openssl'
# searchterm='turbo'
# searchterm='faye'
# searchterm='solargraph'
# searchterm='webpacker'
# searchterm='babel-plugin-macros'
# searchterm='core-js'
# searchterm='puma'
# searchterm='rake'
# searchterm='rake-compiler'
# searchterm='server_health_check'

cd /opt/repo/

# Search for the webpacker gem and store the output in a variable
search_results=$(gem search $(echo $searchterm) --all)

# Read each line of the search results
while IFS= read -r line; do
    # Use a regex to match the package name and capture all version numbers in a group
    if [[ $line =~ ^([a-z0-9_-]+)\ \((.+)\)$ ]]; then
        package="${BASH_REMATCH[1]}"
        versions="${BASH_REMATCH[2]}"
      
        # # Replace commas with spaces to create an array of versions
        IFS=', ' read -r -a version_array <<< "$versions"

        # Sort versions in descending order and get the top 10
        IFS=$'\n' sorted_versions=($(sort -Vr <<<"${version_array[*]}"))
        IFS=' ' read -r -a top_10_versions <<< "${sorted_versions[@]:0:10}"

        # Loop through each of the top 3 versions
        for version in "${top_10_versions[@]}"; do
            # Fetch the specific version of the gem
            gem fetch "$package" --version "$version" --source http://127.0.0.1:9292
            # Fetch dependencies for the specific version of the gem
            gem dependency "$package" --version "$version" --pipe | awk -F " "  '{print $1}' | grep -v "No" | xargs -i gem fetch {} --version "$version" --source http://127.0.0.1:9292
        done
    fi
done <<< "$search_results"

echo "Top 10 newest versions of all $(echo $searchterm) packages have been fetched."



# ----------------------------------------------------------------------------------------------------------------------------

#! Get all the things!!!!!!
# Downloading all the versions from a search

#!/bin/bash

searchterm='mysql2'
# searchterm='rails'
# searchterm='pry'
# searchterm='pry-byebug'
# searchterm='webpacker'
# searchterm='bootsnap'
# searchterm='bootstrap'
# searchterm='ldap3'
# searchterm='rubocop'
# searchterm='capistrano'
# searchterm='react'
# searchterm='rbvmomi'
# searchterm='sass'
# searchterm='babel'
# searchterm='openssl'
# searchterm='sassy'
# searchterm='turbo'
# searchterm='stimulus'
# searchterm='strata'
# searchterm='faye'
# searchterm='solargraph'

# searchterm='webpacker'
# searchterm='babel-plugin-macros'
# searchterm='case-sensitive-paths-webpack-plugin'
# searchterm='core-js'
# searchterm='regenerator-runtime'
# searchterm='goldiloader'
# searchterm='puma'
# searchterm='rake'
# searchterm='rake-compiler'
# searchterm='server_health_check'

cd /opt/repo/


# Search for the webpacker gem and store the output in a variable
search_results=$(gem search $(echo $searchterm) --all)

# Read each line of the search results
while IFS= read -r line; do
    # Use a regex to match the package name and capture all version numbers in a group
    if [[ $line =~ ^([a-z0-9_-]+)\ \((.+)\)$ ]]; then
        package="${BASH_REMATCH[1]}"
        versions="${BASH_REMATCH[2]}"
      
        # Replace commas with spaces to create an array of versions
        IFS=', ' read -r -a version_array <<< "$versions"

        # Iterate over each version in the array and fetch the gem for the package
        for version in "${version_array[@]}"; do
            echo "Fetching $package version $version..."
            gem fetch "$package" -v "$version" --source http://127.0.0.1:9292 
            # gem install -f "$package" -v "$version"
            # gem install -f "$package" -v "$version" --install-dir /opt/repo 
            # gem install -f "$package" -v "$version" --install-dir /opt/repo --source http://localhost:9292 
            gem dependency "$package" --version "$version" --pipe | awk -F " "  '{print $1}' | grep -v "No" | xargs -i gem fetch {} --version "$version" --source http://127.0.0.1:9292
        done
    fi
done <<< "$search_results"

echo "All $(echo $searchterm) packages and versions have been fetched."



# ----------------------------------------------------------------------------------------------------------------------------
#! This one has error checking! 
# Downloading all the versions from a search or webpacker
# # Attempts to only download the searchterm and its versions
#!/bin/bash

searchterm='rails'
# searchterm='pry'
# searchterm='pry-byebug'
# searchterm='react_on_rails'
# searchterm='react-on-rails'
# searchterm='sassc'
# searchterm='webpacker'
# searchterm='babel-plugin-macros'
# searchterm='core-js'
# searchterm='faye'
# searchterm='solargraph'
# searchterm='goldiloader'
# searchterm='puma'
# searchterm='sqlite3'
# searchterm='rake-compiler'
# searchterm='rspec'
# searchterm='rspec-core'
# searchterm='rspec-support'
# searchterm='rspec-expectations'
# searchterm='json'


cd /opt/repo || { echo "Failed to change directory to /opt/repo"; exit 1; }

# Initialize attempt counter
attempt=0
max_attempts=25
success=false

while [ $attempt -lt $max_attempts ]; do
    attempt=$((attempt + 1))
    echo "Attempt $attempt of $max_attempts for search command..."
    search_results=$(gem search $(echo $searchterm) --all) && { success=true; break; } || echo "Search command failed on attempt $attempt."

    if [ $success = false ]; then
        echo "Waiting before retrying..."
        sleep 1 # Wait for 1 second before retrying
    fi
done

if [ $success = false ]; then
    echo "Failed to complete the search command after $max_attempts attempts."
    # exit 1
fi

echo $search_results

# Use grep to isolate the line with just 'webpacker' and its versions
# webpacker_line=$(echo "$search_results" | grep "^$(echo $searchterm) ") || { echo "Grep command failed"; exit 1; }
webpacker_line=$(echo "$search_results" | grep "^$(echo $searchterm) ") || { echo "Grep command failed";  }

# Split the line into an array, first field being the name and the second being the versions
IFS='()' # Internal Field Separator set to '()'
# read -ra ADDR <<< "$webpacker_line" || { echo "Failed to read into array"; exit 1; } # The line is read into an array
read -ra ADDR <<< "$webpacker_line" || { echo "Failed to read into array"; } # The line is read into an array

# Get packages as a first element of the array
package=${ADDR[0]}

# Get versions as a second element of the array
versions=${ADDR[1]}

# Replace commas with spaces to create an array of versions
# IFS=', ' read -r -a version_array <<< "$versions" || { echo "Failed to read versions into array"; exit 1; }
IFS=', ' read -r -a version_array <<< "$versions" || { echo "Failed to read versions into array";  }

# Iterate over each version in the array and fetch the gem
for version in "${version_array[@]}"; do
    echo "Fetching $(echo $searchterm) version $version..."
    gem fetch $(echo $searchterm) -v "$version" --source http://127.0.0.1:9292 || { echo "Failed to fetch $(echo $searchterm) version $version"; continue; }
    # Commented-out commands are skipped for clarity, but you can add error handling in the same way if you uncomment them.
    gem dependency "$package" --version "$version" --pipe | awk -F " "  '{print $1}' | grep -v "No" | xargs -i gem fetch {} --version "$version" --source http://127.0.0.1:9292 || { echo "Failed to fetch dependencies for version $version"; continue; }
    gem dependency "$package" --version "$version" --pipe | awk -F " "  '{print $1}' | grep -v "No" | xargs -i gem install {} --version "$version" --install-dir /opt/repo --source http://127.0.0.1:9292 || { echo "Failed to install dependencies for version $version"; continue; }
done

echo "All versions of $(echo $searchterm) have been fetched."





# # Now loop through the unique gems and download them
# for gem_name in "${!unique_gems[@]}"; do
#     echo "Processing unique gem: $gem_name"
#     # You can add version handling and downloading logic here. Below is a simplified example.

#     webpacker_line=$(echo "$gem_name" | grep "^$(echo $gem_name) ") || { echo "Grep command failed";  }

#     # Split the line into an array, first field being the name and the second being the versions
#     IFS='()' # Internal Field Separator set to '()'
#     read -ra ADDR <<< "$webpacker_line" || { echo "Failed to read into array"; } # The line is read into an array

#     # Get packages as a first element of the array
#     package=${ADDR[0]}

#     # Get versions as a second element of the array
#     versions=${ADDR[1]}

#     echo "Fetching latest version of $gem_name..."

#     # Replace commas with spaces to create an array of versions
#     IFS=', ' read -r -a version_array <<< "$versions" || { echo "Failed to read versions into array";  }

#     # Iterate over each version in the array and fetch the gem
#     for version in "${version_array[@]}"; do
#         echo "Fetching $(echo $gem_name) version $version..."
#         gem fetch $(echo $gem_name) -v "$version" --source http://127.0.0.1:9292 || { echo "Failed to fetch $(echo $gem_name) version $version"; continue; }
#         # Commented-out commands are skipped for clarity, but you can add error handling in the same way if you uncomment them.
#         gem dependency "$package" --version "$version" --pipe | awk -F " "  '{print $1}' | grep -v "No" | xargs -i gem fetch {} --version "$version" --source http://127.0.0.1:9292 || { echo "Failed to fetch dependencies for version $version"; continue; }
#         gem dependency "$package" --version "$version" --pipe | awk -F " "  '{print $1}' | grep -v "No" | xargs -i gem install {} --version "$version" --install-dir /opt/repo --source http://127.0.0.1:9292 || { echo "Failed to install dependencies for version $version"; continue; }
#     done

#     echo "All versions of $(echo $gem_name) have been fetched."

#     # gem fetch "$gem_name" --source http://127.0.0.1:9292 || { echo "Failed to fetch $gem_name"; continue; }
# done

# echo "All unique gems have been processed."



##############################



#!/bin/bash

newName="gemirro,geminabox,webpacker,devise,mongo,redis,jq,jquery"

cd /opt/repo || { echo "Failed to change directory to /opt/repo"; exit 1; }

# Convert comma-separated list of gem names into an array
IFS=',' read -r -a gem_names <<< "$newName"

# Loop through each gem name to search
for gem_name in "${gem_names[@]}"; do
    echo "Searching for gem: $gem_name"

    # Initialize attempt counter
    attempt=0
    max_attempts=5
    success=false

    while [ $attempt -lt $max_attempts ] && [ $success = false ]; do
        attempt=$((attempt + 1))
        echo "Attempt $attempt of $max_attempts for search command..."
        search_results=$(gem search "^$gem_name$" --all) && success=true || echo "Search command failed for $gem_name. Waiting before retrying..."
        
        if [ $success = false ]; then
            sleep 1 # Wait for 1 second before retrying
        fi
    done

    if [ $success = false ]; then
        echo "Failed to complete the search command after $max_attempts attempts for $gem_name."
        continue # Skip to next gem name
    fi

    echo "$search_results"

    # Assuming direct fetching of gems here, you might want to add specific logic to handle versions.
    echo "Fetching latest version of $gem_name..."
    gem fetch "$gem_name" --source http://127.0.0.1:9292 || { echo "Failed to fetch $gem_name"; continue; }
    # Further processing for dependencies can follow a similar pattern.
done

echo "All unique gems have been processed."




##############################
#
# cd /opt/repo 
# # Search for the webpacker gem and store the output in a variable
# search_results=$(gem search $(echo $searchterm) --all)
# # search_results=$(gem search $(echo $searchterm) --all --prerelease)

# # Use grep to isolate the line with just 'webpacker' and its versions
# webpacker_line=$(echo "$search_results" | grep "^$(echo $searchterm) ")

# # Split the line into an array, first field being the name and the second being the versions
# IFS='()' # Internal Field Separator set to '()'
# read -ra ADDR <<< "$webpacker_line" # The line is read into an array

# # Get packages as a first element of the array
# package=${ADDR[0]}

# # Get versions as a second element of the array
# versions=${ADDR[1]}

# # Replace commas with spaces to create an array of versions
# IFS=', ' read -r -a version_array <<< "$versions"


# # Iterate over each version in the array and fetch the gem
# for version in "${version_array[@]}"; do
#     echo "Fetching $(echo $searchterm) version $version..."
#     gem fetch $(echo $searchterm) -v "$version" --source http://127.0.0.1:9292
#     # # gem install -f $(echo $searchterm) -v "$version"
#     # # gem install -f $(echo $searchterm) -v "$version" --install-dir /opt/repo
#     # gem install -f $(echo $searchterm) -v "$version" --install-dir /opt/repo --development-all
#     # # gem install -f $(echo $searchterm) -v "$version" --development-all
#     # # gem install -f $(echo $searchterm) -v "$version" --development-all --prerelease
#     # # gem install -f $(echo $searchterm) -v "$version" --prerelease 
#     # # gem install -f $(echo $searchterm) -v "$version" --prerelease --install-dir /opt/repo 
#     # gem install -f $(echo $searchterm) -v "$version" --prerelease --install-dir /opt/repo --development-all
#     gem dependency "$package" --version "$version" --pipe | awk -F " "  '{print $1}' | grep -v "No" | xargs -i gem fetch {} --version "$version" --source http://127.0.0.1:9292
#     gem dependency "$package" --version "$version" --pipe | awk -F " "  '{print $1}' | grep -v "No" | xargs -i gem install {} --version "$version" --install-dir /opt/repo --source http://127.0.0.1:9292
    
# done

# echo "All versions of $(echo $searchterm) have been fetched."




###############################


# #!/bin/bash

# newName="server_health_check-rack,server_health_check,gemstash,gemirro,geminabox,webpacker,devise,mongo,redis,jq,jquery"

# cd /opt/repo || { echo "Failed to change directory to /opt/repo";  }

# # Convert comma-separated list of gem names into an array
# IFS=',' read -r -a gem_names <<< "$newName"

# # Use associative array to hold unique gems to process
# declare -A unique_gems

# # Loop through each gem name to search and collect unique results
# for gem_name in "${gem_names[@]}"; do
#     echo "Searching for gem: $gem_name"
#     search_results=$(gem search "^$gem_name$" --all) || { echo "Search command failed for $gem_name"; continue; }
    
#     # Extract just the gem name from the search results
#     if [[ "$search_results" =~ ^($gem_name) ]]; then
#         unique_gems[$gem_name]=1
#     fi
# done

# # Now loop through the unique gems and download them
# for gem_name in "${!unique_gems[@]}"; do
#     echo "Processing unique gem: $gem_name"
#     # You can add version handling and downloading logic here. Below is a simplified example.
#     echo "Fetching latest version of $gem_name..."
#     gem fetch "$gem_name" --source http://127.0.0.1:9292 || { echo "Failed to fetch $gem_name"; continue; }
# done

# echo "All unique gems have been processed."






# ----------------------------------------------------------------------------------------------------------------------------

# Testing out a docker search and install

# docker pull bitnami/rails:7
# docker pull bitnami/rails:latest
# docker pull bitnami/rails:7.1.3
# docker pull bitnami/rails:7-debian-11
docker pull bitnami/ruby:latest
docker pull bitnami/rails:5
docker pull bitnami/rails:6
docker pull ruby:latest
# docker pull ruby:3.3.0-bookworm
docker pull ruby:2.7.8-bullseye
docker pull ruby:2.6.10-bullseye
docker pull ruby:3.0-bullseye

docker pull redmine:latest


docker network create -d bridge my-net

# docker run --privileged --rm --name gemstash --network=my-net -p 9292:9292 -it -v 'D:\Transfer\ToMove\repo\rubylatest:/opt/repo' -v 'D:\Transfer\ToMove\repo\gemstashConf:/root/.gemstash'  ruby:latest     bash
docker run --privileged --name gemstash --network=my-net -p 9292:9292 -it -v 'D:\Transfer\ToMove\repo\rubylatest:/opt/repo' -v 'D:\Transfer\ToMove\repo\gemstashConf:/root/.gemstash'  ruby:latest     bash

gem install gemstash
gem install gemstash --install-dir /opt/repo

gemstash start --config-file /opt/repo/gemstash/config.yml

# docker run --name rubylatest --network=my-net -it --rm -v 'D:\Transfer\ToMove\repo\rubylatest:/opt/repo' ruby:latest  bash

# docker inspect gemstash

gem sources -r https://rubygems.org/
# gem sources -a http://127.0.0.1:9292
# gem sources -a http://192.168.0.176:9292
gem sources -a http://172.20.0.2:9292

git clone <stuff>

find /opt -maxdepth 2 -iname "Gemfile" -execdir bundle  \;


###################################################################

docker run -it --rm --network=my-net --name bit_rails5 -d -v 'D:\Transfer\ToMove\repo\bit_rails5:/opt/repo' bitnami/rails:5            bash
docker run -it --rm --network=my-net --name bit_ruby -d -v 'D:\Transfer\ToMove\repo\bit_ruby:/opt/repo' bitnami/ruby:latest          bash
docker run -it --rm --network=my-net --name bit_rails6 -d -v 'D:\Transfer\ToMove\repo\bit_rails6:/opt/repo' bitnami/rails:6            bash
docker run -it --rm --network=my-net --name rubylatest -d -v 'D:\Transfer\ToMove\repo\rubylatest:/opt/repo' ruby:latest                bash
docker run -it --rm --network=my-net --name ruby2.7.8 -d -v 'D:\Transfer\ToMove\repo\ruby2.7.8:/opt/repo' ruby:2.7.8-bullseye         bash
docker run -it --rm --network=my-net --name ruby2.6.10 -d -v 'D:\Transfer\ToMove\repo\ruby2.6.10:/opt/repo' ruby:2.6.10-bullseye       bash
docker run -it --rm --network=my-net --name ruby3 -d -v 'D:\Transfer\ToMove\repo\ruby3:/opt/repo' ruby:3.0-bullseye               bash

    docker exec -it bit_rails5 bash 
    docker exec -it bit_ruby bash
    docker exec -it bit_rails6 bash
    docker exec -it rubylatest bash

    docker exec -it ruby2.7.8 bash
    docker exec -it ruby2.6.10 bash
    docker exec -it ruby3 bash
    
    docker exec -it gemstash bash

# docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\bit_rails5:/opt/repo' bitnami/rails:5            bash -c "gem install geminabox --install-dir /opt/repo"
# docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\bit_ruby:/opt/repo' bitnami/ruby:latest          bash -c "gem install geminabox --install-dir /opt/repo"
# docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\bit_rails6:/opt/repo' bitnami/rails:6            bash -c "gem install geminabox --install-dir /opt/repo"
# docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\rubylatest:/opt/repo' ruby:latest                bash -c "gem install geminabox --install-dir /opt/repo"
# docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\ruby2.7.8:/opt/repo' ruby:2.7.8-bullseye         bash -c "gem install geminabox --install-dir /opt/repo"
# docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\ruby2.6.10:/opt/repo' ruby:2.6.10-bullseye       bash -c "gem install geminabox --install-dir /opt/repo"
# docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\ruby3:/opt/repo' ruby:3.0-bullseye               bash -c "gem install geminabox --install-dir /opt/repo"


# # Using minikube, the volumes have to be mounted to the hyperv VM for docker to see them
# docker run -it --rm -d -v '/opt/Transfer/ToMove/repo/bit_rails5:/opt/repo' bitnami/rails:5            bash
# docker run -it --rm -d -v '/opt/Transfer/ToMove/repo/bit_ruby:/opt/repo' bitnami/ruby:latest          bash
# docker run -it --rm -d -v '/opt/Transfer/ToMove/repo/bit_rails6:/opt/repo' bitnami/rails:6            bash
# docker run -it --rm -d -v '/opt/Transfer/ToMove/repo/rubylatest:/opt/repo' ruby:latest                bash
# docker run -it --rm -d -v '/opt/Transfer/ToMove/repo/ruby2.7.8:/opt/repo' ruby:2.7.8-bullseye         bash
# docker run -it --rm -d -v '/opt/Transfer/ToMove/repo/ruby2.6.10:/opt/repo' ruby:2.6.10-bullseye       bash
# docker run -it --rm -d -v '/opt/Transfer/ToMove/repo/ruby3:/opt/repo' ruby:3.0-bullseye               bash

 
# docker run -it --rm -d -v '/opt/Transfer/ToMove/repo/bit_rails5:/opt/repo' bitnami/rails:5            bash -c "gem install geminabox --install-dir /opt/repo"
# docker run -it --rm -d -v '/opt/Transfer/ToMove/repo/bit_ruby:/opt/repo' bitnami/ruby:latest          bash -c "gem install geminabox --install-dir /opt/repo"
# docker run -it --rm -d -v '/opt/Transfer/ToMove/repo/bit_rails6:/opt/repo' bitnami/rails:6            bash -c "gem install geminabox --install-dir /opt/repo"
# docker run -it --rm -d -v '/opt/Transfer/ToMove/repo/rubylatest:/opt/repo' ruby:latest                bash -c "gem install geminabox --install-dir /opt/repo"
# docker run -it --rm -d -v '/opt/Transfer/ToMove/repo/ruby2.7.8:/opt/repo' ruby:2.7.8-bullseye         bash -c "gem install geminabox --install-dir /opt/repo"
# docker run -it --rm -d -v '/opt/Transfer/ToMove/repo/ruby2.6.10:/opt/repo' ruby:2.6.10-bullseye       bash -c "gem install geminabox --install-dir /opt/repo"
# docker run -it --rm -d -v '/opt/Transfer/ToMove/repo/ruby3:/opt/repo' ruby:3.0-bullseye               bash -c "gem install geminabox --install-dir /opt/repo"


# $newName="pry,pry-byebug,hoe,react,mysql2,pg,sqlite3,tzinfo,capistrano,sass,sassc,rails,mongo,jquery,redis,devise,sidekiq,rspec,carrierwave,bootstrap,haml,omniauth,activeadmin,ldap"
# $newName = gc .\OneDrive\Documents\gems.txt
$newName = gc ~\OneDrive\Documents\gems.txt

$newName | Foreach-Object { 
    docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\bit_rails5:/opt/repo' bitnami/rails:5            sh -c "gem install $_ -f --install-dir /opt/repo"
    # docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\bit_ruby:/opt/repo' bitnami/ruby:latest          sh -c "gem install $_ -f --install-dir /opt/repo"
    # docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\bit_rails6:/opt/repo' bitnami/rails:6            sh -c "gem install $_ -f --install-dir /opt/repo"
    # docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\rubylatest:/opt/repo' ruby:latest                sh -c "gem install $_ -f --install-dir /opt/repo"
    # docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\ruby2.7.8:/opt/repo' ruby:2.7.8-bullseye         sh -c "gem install $_ -f --install-dir /opt/repo"
    # docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\ruby2.6.10:/opt/repo' ruby:2.6.10-bullseye       sh -c "gem install $_ -f --install-dir /opt/repo"
    # docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\ruby3:/opt/repo' ruby:3.0-bullseye               sh -c "gem install $_ -f --install-dir /opt/repo"
    }


$newName | Foreach-Object { 
    docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\bit_rails5:/opt/repo' bitnami/rails:5            sh -c "gem install $_ -f --install-dir /opt/repo"
    Start-Sleep -s 1
    }


$newName | Foreach-Object { 
    docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\bit_ruby:/opt/repo' bitnami/ruby:latest          sh -c "gem install $_ -f --install-dir /opt/repo"
    Start-sleep -s 1
    }


$newName | Foreach-Object { 
    docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\bit_rails6:/opt/repo' bitnami/rails:6            sh -c "gem install $_ -f --install-dir /opt/repo"
    Start-sleep -s 1
    }


$newName | Foreach-Object { 
    docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\rubylatest:/opt/repo' ruby:latest                sh -c "gem install $_ -f --install-dir /opt/repo"
    Start-sleep -s 1
    }


$newName | Foreach-Object { 
    docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\ruby2.7.8:/opt/repo' ruby:2.7.8-bullseye         sh -c "gem install $_ -f --install-dir /opt/repo"
    Start-sleep -s 1
    }


$newName | Foreach-Object { 
    docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\ruby3:/opt/repo' ruby:3.0-bullseye               sh -c "gem install $_ -f --install-dir /opt/repo"
    Start-sleep -s 1
    }


$newName | Foreach-Object { 
    docker run -it --rm -d -v 'D:\Transfer\ToMove\repo\ruby2.6.10:/opt/repo' ruby:2.6.10-bullseye       sh -c "gem install $_ -f --install-dir /opt/repo"
    Start-sleep -s 1
    }


gem install faye -f --install-dir /opt/repo --source http://172.20.0.9:9292 --development-all

# ----------------------------------------------------------------------------------------------------------------------------
#It Broke....
# # Seconds Best one!!!

# echo "" > newFiles

# for j in $(cat newFiles_pull) 
#     do gem search "$j" >> newFiles 
# done

# for i in $(cat newFiles | awk -F " "  '{print $1}' | sort -u)
#     do gem fetch "$i" 
#     gem dependency "$i" --pipe | awk -F " "  '{print $1}' | grep -v "No" | parallel gem fetch 
# done

# ----------------------------------------------------------------------------------------------------------------------------

for i in $NAME 
    # do gem fetch $(gem dependency "$i" --pipe | awk -F " "  '{print $1}' | grep -vi "No") 
    do $(gem dependency "$i" --pipe | awk -F " "  '{print $1}' | grep -v "No" >> newFiles)
    # do gem dependency "$i" --pipe | awk -F " "  '{print $1}' | sort -u
    echo "$i" >> newFiles
done

sort -u newFiles > newFiles2
mv newFiles2 newFiles_pull

for i in $(cat newFiles_pull) 
    do gem fetch "$i" 
    gem dependency "$i" --pipe | awk -F " "  '{print $1}' | grep -v "No" | parallel gem fetch 
done



# cat newFiles_pull | parallel gem fetch



# gem sources --add http://192.168.0.176/rubygems/rubygems/

# gem fetch $NAME;
# gem dependency faye rails --pipe | awk -F " "  '{print $1}' | xargs gem fetch
# gem dependency $NAME --pipe | awk -F " "  '{print $1}' | xargs gem fetch
# gem dependency $NAME --pipe | awk -F " "  '{print $1}' | xargs -i gem fetch {} -s http://192.168.0.176/rubygems/rubygems/ 


# for i in $NAME ; do gem dependency "$i" --pipe | awk -F " "  '{print $1}' | xargs -i gem fetch {} -s http://192.168.0.176/rubygems/rubygems/ ; done
# for i in $NAME ; do echo "$i" ; done
# for i in $NAME ; do gem fetch $(gem dependency -s http://192.168.0.176/rubygems/rubygems/ "$i" --pipe | awk -F " "  '{print $1}' | sort -u) -s http://192.168.0.176/rubygems/rubygems/ ; done

# gem dependency $NAME --pipe | awk -F " "  '{print $1}' | xargs -i gem fetch {} -s http://192.168.0.176/rubygems/rubygems/ 
# 
###################################################################


###################################################################
#! RUBY GEMS!!!!!!!!

cd /opt/repo/


NAME="aasm achdirect-activemerchant action_mailer_matchers action_merchant actioncable actionmailer actionpack actionview active_accountability_merchant active_cart active_copy active_crud active_form active_merchant_allpay active_merchant_card_flex active_merchant_ccavenue active_merchant_cyber_source_subscriptions active_merchant-epsilon active_merchant-paypal-bogus-gateway active_model_serializer-matchers active_model_serializers_matchers active_model_serializers-matchers active_orm active_poro active_record_block_matchers active_road active-cart activecord activeform activejob ActiveMerchant-FatZebra activemodel activerecord activestorage activesupport admin admin_invitable administrate aerial ahoy alancse-friendly_id Alimento ancestry animate-rails annotable apertium api_matchers ar-query-matchers ardm-active_model arel assit async_sinatra audit auditable autotools aws-ie backport_new_renderer backstretch-rails Bacon_FS_Matchers basic_active_model bcrypt bcrypt_pbkdf bcrypt-ruby better better_errors bindings binfinity-rails bmo-mini_magick bootsnap brakeman browser-timezone-rails builder bullet bundler bundler-audit byebug cache_driver cancancan capistrano capistrano-dotenv capistrano-dotenv-tasks capistrano-rails capistrano-rails-dotenv capistrano-rvm capistrano3-dotenv-check capistrano3-dotenv-upload capybara capybara-chromedriver-logger capybara-screenshot carrierwave casento cassie cells chef chrome_diff chrome_logger chromedriver chromedriver-helper chromedriver-installer chromedriver-screenshot chromedriver2-helper cleaner cmassimo-friendly_id coffee-react combodate-rails concurrent-ruby config conflate-rails cuba-tools daemons database dayrb debsacker delayed detect_timezone_rails devisable devise devise_invitable did_active_model discard distant dot_env dot-env dotenv dotenv-android dotenv-beefy dotenv-configuration dougcole-friendly_id dragonfly-minimagick draper drb-rb dry-data-rails dry-rb dsturnbull-mini_magick dynamic-active-model edouard-mini_magick elasticsearch em-websocket enviable errors erubi eslint-webpacker eventmachine factory_bot faker faye faye-websocket figaro filepond-rails fingerrails fis-test form friend-feed friendable friendfeed friendly friendly_code friendly_fk friendly_id friendly_id_datamapper friendly_id_globalize3 friendly_id_sequel friendly_id-method_scopes friendly_id-mobility friendly_key friendly_slug friendly_uuid friendlyfashion-parallel_tests friendlyid friendlyld geothird_friendly_id gistto globalid globalize grape GUI-mini_magick guide haml has_partial has_scope hashie hasscope hassle hastie hbase-driver hcatlin-mini_magick headers hirb hoe hotwire-rails i18n i18n-tasks iconate_rails ikm-chromedriver-helper impartial informant-rails informix_rails insta-rails intent interact-rails interactor-rails invisible invitable invokable ip-writer-rails irbtools ivento jbuilder jekyll-minimagick jetpacker jf--mini_magick job JonathanTron-rspec_sequel_matchers jquery-rails json-jwt jsonapi-serializer jsTimezoneDetect-rails juicer-rails jwt kaminari leifcr-refile-mini_magick letter libretto listen listen-to listener lockbox loofah lperichon-devise_invitable mail makerspace-react-rails marcel masse massive matchers mcmire-shoulda-matchers merchant meta method_source middleman-react middleman-webpacker mina-webpacker mini_magick mini_racer mini_racer-rails minidynamo minimagick minispade-rails minispec-rails minitest minitest-activemodel minitest-global_expectations minitest-reporters-parallel_tests_reporter minitest-sprint minivite_rails mirador_rails moment_timezone-rails moment-timezone-rails money-rails mongoid_paranoia mongoid-audit mongoid-danger mongoid-day_time mongoid-doable mongoid-enum mongoid-enum-logn mongoid-name mongoid-paranoia mongoiddynamoid moxiesoft_parallel_tests nashie nio4r nobrainer nokogiri omniauth opener ossie overcommit pagy paper_tag paper_trail paperclip paperclip-s3 paperclip-sftp paperclip-smart_data_uri_adapter paperclip-smusher paperclip-staging paperclip-storage-aliyun paperclip-storage-ftp paperclip-storage-tmp paperclip-streamio-ffmpeg paperclip-strip-strange-characters paperclips paperdrive papermill papertrail papertrial paperwrap parallel_tests parallel_tests_report parallel_tests-extensions parallel_tests-fine_grain_test parallel_tests-instructure paralleltests paranoia pg_search phene-parallel_tests piecon-rails pry pry-byebug puma pundit rack rack-protection rack-proxy rack-test rails rails_admin rails_best_practices rails_com rails_doc rails_domain_model rails_dominant_colors rails_health_checker rails_react_components rails_react_scaffold rails_react_stdio rails_reset rails-acm rails-acu rails-api rails-chat rails-data-explorer rails-dev-tweaks rails-dom rails-dom-testing rails-domain rails-html-sanitizer rails-observers rails-react rails-react-ssr rails-react-views rails-react-webpacker rails-route-checker rails-webpack railsdoc railsdomtesting RailsTop railties rake ransack react react_devise react_on_rails react-bootstrap-rails react-devise react-jsx react-rails react-router-rails react-source react-webpack-rails react-webpacker react.rb redis redis-retry reek remarkable_devise_invitable rescue-retry robocop rolify route_translator routetranslator rsecret rspec rspec_pretty rspec-core rspec-crampy rspec-crispy rspec-eth rspec-retry rspec-retry_ex rspec::retry rswag rubocop rubocop-performance rubtools ruby ruby_jwt ruby-debug ruby-debug19 ruby-jwt ruby-tools rubyzip sass sassie sassy secure semantic_analysis semantic_antispam semantic_range semantic_rangeaasm semantic-crawler semantic-fa-sass semantic-mapper semantic-rails semantic-rails-ui semantic-rainbow semantic-ui-sass shoulda shoulda_matchers shoulda-activemodel shoulda-matchers shoulda-matchers-callbacks shoulda-matchers-cucumber shoulda-matchers-graphql shoulda-matchers-pundit shoulda-matchers-uuid shoulda-matchers-viewcomponent shrine sidekiq sidekiq-scheduler simple simple_command simplecov sinatra sinatra-active_action sinatra-active-model-serializers sinatra-activemodel sinatra-activerecord sinatra-asset-pipeline sinatra-assetpack sinatra-contrib sinatra-cross_origin sinatra-reloader sinatra-respond_to sinatra-sequel sinatra-websocket slim snap_ci-parallel_tests spring spring-watcher-listen sprockets sprockets-rails stripe style tabledata-rails tabtools tags test-unit themes_on_rails thin thinking-sphinx-shoulda-matchers thor thread_safe ti time_zone_ext time_zones_api time-zone time-zone-warp timeline_rails timelineJS_rails timelineJS-rails timelineJS3-rails timeliner_rails timezone timezone_detection timezone_dropdown timezone_lat_lon timezone_local timezone-aware timezone-data timezone-data-rails timezone-data-tzinfo timezone-data-tzinfo-rails timezone-rails timezone-to-utc timezonedb-client TimezoneParser tryrb turbo_cells turbo_tests turbo-rails turboboost turbolinks turbotools tz tzinfo tzinfo-data tzinfo-data-rails uglifier vcr virtual_time_zone_rails WatersOfOblivion-easy-matchers web_package-rails web-connect-rails web-console web-facter webmock webpack_react_on_rails webpack-rails webpack-rails-react webpack2-rails webpack4r webpacked webpacker webpacker-preact webpacker-r webpacker-react webpacker-react-on-rails webpacker-react-rails webpacker-react-server-renderer webpacker-remote webpacker-routes websocket-driver wicked_pdf will_paginate wkhtmltopdf wkhtmltopdf-binary zip "



##################################################
##################################################
##################################################
##################################################
##################################################
##################################################