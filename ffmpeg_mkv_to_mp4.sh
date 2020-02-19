#!/bin/bash

 for i in *.mkv ; do ffmpeg -i "$i" -f mp4 -vcodec libx264 -preset fast -profile:v main -acodec aac "$i".mp4 -hide_banner; done
