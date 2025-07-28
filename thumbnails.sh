#!/bin/bash

# $1 is youtube id
# $2 is path, if empty, download here

videoid=$1
path=$2

# if user did not give a videoid, explain script
if [[ $videoid == "" ]]; then
  echo "usage: ${0} videoid path"
  echo "leave path empty to download to current directory"
  exit 0
fi

# if user did not give a path, assume download to current directory
if [[ $path == "" ]]; then
  path=./
fi

fullpath="$path"

# check if path leads to a folder or not. If it leads to a folder,
# make it lead to a file that will be created. If it doesn't lead
# to a folder, it will choose a filename for the file automatically
if [ -d "$path" ]; then
  fullpath="${path}/${videoid}.jpg"
fi

# if the file already exists, ask the user if they want to replace it
# if they dont, exit the script
if [ -f "$fullpath" ]; then 
  read -p "$fullpath already exists. Would you like to replace it? [y/n] " replace
  if [[ "$replace" != "y" ]]; then
    exit 0
  fi
fi

# figure out what url to download from and then do the download
url="https://img.youtube.com/vi/${videoid}/maxresdefault.jpg"
curl -L -o "$fullpath" "$url"
