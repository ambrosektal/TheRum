#!/bin/bash

# for file in /path/to/recovered/files/*; do
# for file in $(find . -type f); do
find . -type f | while read file; do
    type=$(file -b --mime-type "$file")
    case "$type" in
    "image/jpeg")
        mv "$file" "${file%.*}.jpg"
        ;;
    "image/png")
        mv "$file" "${file%.*}.png"
        ;;
    "image/gif")
        mv "$file" "${file%.*}.gif"
        ;;
    "image/bmp")
        mv "$file" "${file%.*}.bmp"
        ;;
    "image/tiff")
        mv "$file" "${file%.*}.tiff"
        ;;
    "image/x-ms-bmp")
        mv "$file" "${file%.*}.bmp"
        ;;
    "image/x-canon-cr2")
        mv "$file" "${file%.*}.cr2"
        ;;
    "image/x-nikon-nef")
        mv "$file" "${file%.*}.nef"
        ;;
    "image/x-olympus-orf")
        mv "$file" "${file%.*}.orf"
        ;;
    "image/x-panasonic-rw2")
        mv "$file" "${file%.*}.rw2"
        ;;
    "image/x-pentax-pef")
        mv "$file" "${file%.*}.pef"
        ;;
    "image/x-sony-arw")
        mv "$file" "${file%.*}.arw"
        ;;
    "image/x-ico")
        mv "$file" "${file%.*}.ico"
        ;;
    "image/x-tga")
        mv "$file" "${file%.*}.tga"
        ;;
    "application/octet-stream")
        mv "$file" "${file%.*}.octet-stream"
        ;;
    "application/json")
        mv "$file" "${file%.*}.json"
        ;;
    "application/x-dbt")
        mv "$file" "${file%.*}.dbt"
        ;;
    "application/x-stargallery-thm")
        mv "$file" "${file%.*}.stargallery-thm"
        ;;
    "application/CDFV2")
        mv "$file" "${file%.*}.cdfv2"
        ;;
    "application/zlib")
        mv "$file" "${file%.*}.zlib"
        ;;
    "application/gzip")
        mv "$file" "${file%.*}.gz"
        ;;
    "application/x-tex-tfm")
        mv "$file" "${file%.*}.tfm"
        ;;
    "inode/x-empty")
        mv "$file" "${file%.*}.empty"
        ;;
    "application/x-ms-sdi")
        mv "$file" "${file%.*}.sdi"
        ;;
    "image/jpeg")
        mv "$file" "${file%.*}.jpg"
        ;;
    "image/png")
        mv "$file" "${file%.*}.png"
        ;;
    "image/gif")
        mv "$file" "${file%.*}.gif"
        ;;
    "application/pdf")
        mv "$file" "${file%.*}.pdf"
        ;;
    "text/plain")
        mv "$file" "${file%.*}.txt"
        ;;
    "application/zip")
        mv "$file" "${file%.*}.zip"
        ;;
    "application/x-rar-compressed")
        mv "$file" "${file%.*}.rar"
        ;;
    "application/x-tar")
        mv "$file" "${file%.*}.tar"
        ;;
    "application/x-7z-compressed")
        mv "$file" "${file%.*}.7z"
        ;;
    "application/vnd.ms-powerpoint")
        mv "$file" "${file%.*}.ppt"
        ;;
    "application/vnd.ms-excel")
        mv "$file" "${file%.*}.xls"
        ;;
    "application/msword")
        mv "$file" "${file%.*}.doc"
        ;;
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document")
        mv "$file" "${file%.*}.docx"
        ;;
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        mv "$file" "${file%.*}.xlsx"
        ;;
    "application/vnd.mozilla.xul+xml")
        mv "$file" "${file%.*}.xul"
        ;;
    "application/x-javascript")
        mv "$file" "${file%.*}.js"
        ;;
    "application/x-shockwave-flash")
        mv "$file" "${file%.*}.swf"
        ;;
    "audio/mpeg")
        mv "$file" "${file%.*}.mp3"
        ;;
    "audio/ogg")
        mv "$file" "${file%.*}.ogg"
        ;;
    "audio/wav")
        mv "$file" "${file%.*}.wav"
        ;;
    "image/bmp")
        mv "$file" "${file%.*}.bmp"
        ;;
    "image/icon")
        mv "$file" "${file%.*}.ico"
        ;;
    "image/svg+xml")
        mv "$file" "${file%.*}.svg"
        ;;
    "text/csv")
        mv "$file" "${file%.*}.csv"
        ;;
    "text/html")
        mv "$file" "${file%.*}.html"
        ;;
    "text/xml")
        mv "$file" "${file%.*}.xml"
        ;;
    "video/avi")
        mv "$file" "${file%.*}.avi"
        ;;
    "video/mp4")
        mv "$file" "${file%.*}.mp4"
        ;;
    "video/mpeg")
        mv "$file" "${file%.*}.mpeg"
        ;;
    "video/quicktime")
        mv "$file" "${file%.*}.mov"
        ;;
    "video/x-ms-wmv")
        mv "$file" "${file%.*}.wmv"
        ;;
    "application/x-msdownload")
        mv "$file" "${file%.*}.exe"
        ;;
    "application/x-java-archive")
        mv "$file" "${file%.*}.jar"
        ;;
    "application/vnd.android.package-archive")
        mv "$file" "${file%.*}.apk"
        ;;
    "application/x-msaccess")
        mv "$file" "${file%.*}.mdb"
        ;;
    "application/x-sh")
        mv "$file" "${file%.*}.sh"
        ;;
    "application/x-perl")
        mv "$file" "${file%.*}.pl"
        ;;
    "application/x-python")
        mv "$file" "${file%.*}.py"
        ;;
    "application/x-php")
        mv "$file" "${file%.*}.php"
        ;;
    "application/x-rpm")
        mv "$file" "${file%.*}.rpm"
        ;;
    "application/x-iso9660-image")
        mv "$file" "${file%.*}.iso"
        ;;
    "application/x-gzip")
        mv "$file" "${file%.*}.gz"
        ;;
    "application/x-bzip2")
        mv "$file" "${file%.*}.bz2"
        ;;
    "application/x-dosexec")
        mv "$file" "${file%.*}.com"
        ;;
    "application/x-object")
        mv "$file" "${file%.*}.o"
        ;;
    "application/vnd.oasis.opendocument.text")
        mv "$file" "${file%.*}.odt"
        ;;
    "application/vnd.oasis.opendocument.spreadsheet")
        mv "$file" "${file%.*}.ods"
        ;;
    "application/vnd.oasis.opendocument.presentation")
        mv "$file" "${file%.*}.odp"
        ;;
    "application/vnd.apple.keynote")
        mv "$file" "${file%.*}.key"
        ;;
    "application/vnd.google-earth.kml+xml")
        mv "$file" "${file%.*}.kml"
        ;;
    "application/vnd.google-earth.kmz")
        mv "$file" "${file%.*}.kmz"
        ;;
    "application/vnd.mozilla.xul+xml")
        mv "$file" "${file%.*}.xul"
        ;;
    "application/x-mspublisher")
        mv "$file" "${file%.*}.pub"
        ;;
    "application/x-font-ttf")
        mv "$file" "${file%.*}.ttf"
        ;;
    "application/font-woff")
        mv "$file" "${file%.*}.woff"
        ;;
    "application/vnd.ms-cab-compressed")
        mv "$file" "${file%.*}.cab"
        ;;
    "application/x-chm")
        mv "$file" "${file%.*}.chm"
        ;;
    "application/x-ms-wim")
        mv "$file" "${file%.*}.wim"
        ;;
    "application/x-msi")
        mv "$file" "${file%.*}.msi"
        ;;
    "application/x-shockwave-flash")
        mv "$file" "${file%.*}.swf"
        ;;
    "application/x-ole-storage")
        mv "$file" "${file%.*}.ole"
        ;;
    "image/webp")
        mv "$file" "${file%.*}.webp"
        ;;
    "image/vnd.adobe.photoshop")
        mv "$file" "${file%.*}.psd"
        ;;
    "image/x-icon")
        mv "$file" "${file%.*}.ico"
        ;;
    "image/vnd.microsoft.icon")
        mv "$file" "${file%.*}.ico"
        ;;
    "image/x-xbitmap")
        mv "$file" "${file%.*}.xbm"
        ;;
    "image/x-xpixmap")
        mv "$file" "${file%.*}.xpm"
        ;;
    "image/x-ms-bmp")
        mv "$file" "${file%.*}.bmp"
        ;;
    "image/x-canon-cr2")
        mv "$file" "${file%.*}.cr2"
        ;;
    "image/x-nikon-nef")
        mv "$file" "${file%.*}.nef"
        ;;
    "image/x-olympus-orf")
        mv "$file" "${file%.*}.orf"
        ;;
    "image/x-panasonic-rw2")
        mv "$file" "${file%.*}.rw2"
        ;;
    "image/x-pentax-pef")
        mv "$file" "${file%.*}.pef"
        ;;
    "image/x-sony-arw")
        mv "$file" "${file%.*}.arw"
        ;;
    "image/x-ico")
        mv "$file" "${file%.*}.ico"
        ;;
    "video/x-msvideo")
        mv "$file" "${file%.*}.avi"
        ;;
    "video/mp4")
        mv "$file" "${file%.*}.mp4"
        ;;
    "video/mpeg")
        mv "$file" "${file%.*}.mpeg"
        ;;
    "video/quicktime")
        mv "$file" "${file%.*}.mov"
        ;;
    "video/x-ms-wmv")
        mv "$file" "${file%.*}.wmv"
        ;;
    "video/x-flv")
        mv "$file" "${file%.*}.flv"
        ;;
    "video/x-matroska")
        mv "$file" "${file%.*}.mkv"
        ;;
    "video/x-ms-asf")
        mv "$file" "${file%.*}.asf"
        ;;
    "video/webm")
        mv "$file" "${file%.*}.webm"
        ;;
    "video/x-avi")
        mv "$file" "${file%.*}.avi"
        ;;
    "video/x-f4v")
        mv "$file" "${file%.*}.f4v"
        ;;
    "video/x-fli")
        mv "$file" "${file%.*}.fli"
        ;;
    "video/x-flv")
        mv "$file" "${file%.*}.flv"
        ;;
    "video/x-m4v")
        mv "$file" "${file%.*}.m4v"
        ;;
    "video/x-matroska")
        mv "$file" "${file%.*}.mkv"
        ;;
    "video/x-mng")
        mv "$file" "${file%.*}.mng"
        ;;
    "video/x-ms-asf")
        mv "$file" "${file%.*}.asf"
        ;;
    "video/x-ms-wm")
        mv "$file" "${file%.*}.wm"
        ;;
    "video/x-ms-wmv")
        mv "$file" "${file%.*}.wmv"
        ;;
    "video/x-ms-wmx")
        mv "$file" "${file%.*}.wmx"
        ;;
    "video/x-ms-wvx")
        mv "$file" "${file%.*}.wvx"
        ;;
    "video/x-nsv")
        mv "$file" "${file%.*}.nsv"
        ;;
    "video/x-ogm")
        mv "$file" "${file%.*}.ogm"
        ;;
    "video/x-mpegurl")
        mv "$file" "${file%.*}.m3u"
        ;;
    "video/3gpp")
        mv "$file" "${file%.*}.3gp"
        ;;
    "video/3gpp2")
        mv "$file" "${file%.*}.3g2"
        ;;
    "video/vnd.rn-realvideo")
        mv "$file" "${file%.*}.rv"
        ;;
    "video/vnd.vivo")
        mv "$file" "${file%.*}.viv"
        ;;
    "video/x-dv")
        mv "$file" "${file%.*}.dv"
        ;;
    "video/x-ms-dvr")
        mv "$file" "${file%.*}.dvr-ms"
        ;;
    *)
        echo "Unknown file type: $type"
        ;;
    esac

done
