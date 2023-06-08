#!/bin/bash

filetypes=('gif' 'jpg' 'jpeg' 'png' 'bmp' 'zip' '7z' 'rar' 'tar' 'gz' 'xz' 'bz' 'zlib' 'exe' 'msi' 'com' '3g2' '3gp' 'asf' 'avi' 'flv' 'm4v' 'mkv' 'mov' 'mp4' 'mpg' 'mpeg' 'rm' 'swf' 'vob' 'wmv' 'webm' 'ogv' 'qt' 'aac' 'aif' 'aiff' 'amr' 'au' 'flac' 'm4a' 'mp3' 'ogg' 'wav' 'wma' 'weba' 'opus' 'xls' 'xlsx' 'xlsm' 'xlsb' 'xlt' 'xltx' 'xltm' 'ods' 'csv' 'tsv' 'gnumeric' '123' 'wk1' 'wk3' 'wk4' 'wks' 'ppt' 'pptx' 'pps' 'ppsx' 'pot' 'potx' 'odp' 'sda' 'sdd' 'shw' 'show' 'sti' 'key' 'odb' 'mdb' 'accdb' 'dbf' 'fp7' 'sqlite' 'sqlite3' 'sql' 'db' 'pub' 'mcf' 'indd' 'idml' 'pmd' 'sla' 'sla.gz' 'scd' 'stc' 'sxg' 'ott' 'dotm' 'dotx' 'odf' 'mml' 'sxm' 'smf' 'odc' 'oth' 'otp' 'ots' 'xsd' 'xsl' 'dtd' 'one' 'enex' 'vsd' 'vsdx' 'vdx' 'vdw' 'vss' 'vst' 'vtx' 'vsx' 'vsl' 'vssx' 'vstx' 'vsw' 'odg' 'otg' 'drawio' 'xml' 'xmlx' 'doc' 'docx' 'dot' 'dotx' 'odt' 'rtf' 'txt' 'pdf' 'wps' 'wpd' 'abw' 'lwp')

destdir='/mnt/e/BasicDataPartition/BasicDataRoot/'

# for i in "$filetypes";
#     do for j in $(find . -type f -name "*.$i");
#         # do mv "$file" "$destdir"
#         do echo "$j will be moved into $destdir"
#     done
# done



# for i in "$filetypes";
#     # do find . -type f -name "*.$i" -exec echo "{} will be moved here: $destdir" \;
#     # do find . -type f -name "*.$i" -exec mv {} $destdir  \;
#     do find . -type f -exec if {}
# done

find . -type f | while read -r file; do
    for type in "${filetypes[@]}"; do
        if [[ $file == *"."$type ]]; then
            # echo mv "$file" "$destdir"
            mv "$file" "$destdir"
        fi
    done
done


