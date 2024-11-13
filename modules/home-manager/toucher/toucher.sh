#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

# Get template dir
templates="$TOUCHER_TEMPLATES"

if [ ! -d "$templates" ]; then
  echo "Error: Couldn't find templates dir (\$TOUCHER_TEMPLATES)"
  exit 1
fi

# Get new file name
newfile="$1"

if [ -e "$newfile" ]; then
  echo "Error: '$newfile' already exists"
  exit 1
fi

# Create new file
touch "$newfile"
created="$?"

if [ "$created" -ne "0" ]; then
  echo "Error: '$newfile' could not be created (touch returned '$created')"
  exit 1
fi

echo "File created"

# Get file extension
filename=$(basename -- "$newfile")

# Check no extension case
if [[ ! "$filename" == *.* ]]; then
  echo "No extension, no templating"
  exit 0
fi

extension=${filename##*.}

# Check for extension dir
if [ ! -d "${templates}/${extension}" ]; then
  echo "No template dir for '.${extension}' files found"
  exit 0
fi

# Check for specific or default template
template_spe="${templates}/${extension}/${filename}" 
template_def="${templates}/${extension}/default.${extension}"

if [ -f "$template_spe" ]; then
  cat "$template_spe" > "$newfile"
  echo "File pre-populated (specific)"
  exit 0
fi

if [ -f "$template_def" ]; then
  cat "$template_def" > "$newfile"
  echo "File pre-populated (default)"
  exit 0
fi

echo "No default templae found"
