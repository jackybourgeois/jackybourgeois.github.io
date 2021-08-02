#!/usr/bin/env bash

# ------------------------------------------------------------------------------
#
# Program: initpost.sh
# Author:  Vitor Britto
# Description: script to create an initial structure for my posts.
#
# Usage: ./initpost.sh [options] <post name>
#
# Options:
#   -h, --help        output instructions
#   -c, --create      create post
#
# Alias: alias ipost="bash ~/path/to/script/initpost.sh"
#
# Example:
#   ./initpost.sh -c How to replace strings with sed
#
# Important Notes:
#   - This script was created to generate new markdown files for my blog.
#
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# | VARIABLES                                                                  |
# ------------------------------------------------------------------------------

# CORE: Do not change these lines
# ----------------------------------------------------------------
NOTE_TITLE="${@:2:$(($#-1))}"
NOTE_NAME="$(echo ${@:2:$(($#-1))} | sed -e 's/ /-/g' | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/")"
CURRENT_DATE="$(date -u +'%Y-%m-%d')"
TIME=$(date -u +"%T")
FILE_NAME="${CURRENT_DATE}-${NOTE_NAME}.md"
# ----------------------------------------------------------------


# SETTINGS: your configuration goes here
# ----------------------------------------------------------------

# Set your destination folder
BINPATH=$(cd `dirname $0`; pwd)
NOTEPATH="./_notes"
DIST_FOLDER="$NOTEPATH"

# Set your blog URL
BLOG_URL="https://jackybourgeois.com"

# Set your assets URL
ASSETS_URL="assets/images/"
# ----------------------------------------------------------------



# ------------------------------------------------------------------------------
# | UTILS                                                                      |
# ------------------------------------------------------------------------------

# Header logging
e_header() {
    printf "$(tput setaf 38)→ %s$(tput sgr0)\n" "$@"
}

# Success logging
e_success() {
    printf "$(tput setaf 76)✔ %s$(tput sgr0)\n" "$@"
}

# Error logging
e_error() {
    printf "$(tput setaf 1)✖ %s$(tput sgr0)\n" "$@"
}

# Warning logging
e_warning() {
    printf "$(tput setaf 3)! %s$(tput sgr0)\n" "$@"
}



# ------------------------------------------------------------------------------
# | MAIN FUNCTIONS                                                             |
# ------------------------------------------------------------------------------

# Everybody need some help
initpost_help() {

cat <<EOT
------------------------------------------------------------------------------
INIT POST - A shortcut to create an initial structure for my posts.
------------------------------------------------------------------------------
Usage: ./initpost.sh [options] <post name>
Options:
  -h, --help        output instructions
  -c, --create      create post
Example:
  ./initpost.sh -c How to replace strings with sed
Important Notes:
  - This script was created to generate new text files to my blog.
Copyright (c) Vitor Britto
Licensed under the MIT license.
------------------------------------------------------------------------------
EOT

}

# Initial Content
initpost_content() {
echo "---"
echo "title: \"${NOTE_TITLE}\""
echo "date: ${CURRENT_DATE} ${TIME}"
echo "categories: [Notes,Ideas]"
echo "tags: []"
echo "backlinks: []"
echo "---"
echo ""
echo "__What does it means?, How does it connect to...? What is the difference between...? What is it similar to?__"
echo ""
echo "__add link to reference in the note__"
echo ""
echo "__Literature notes are written in the context of the source they were inspired by. Whereas permanent notes are written in the context of your own ideas and interests.__"
echo ""
echo "__Literature notes only have one connection, to the book they came from. While permanent notes can have many connections (to individual notes, as part of multiple topics etc).__"
}

# Create file
initpost_file() {
    if [ ! -f "$FILE_NAME" ]; then
        e_header "Creating template..."
        initpost_content > "${DIST_FOLDER}/${FILE_NAME}"
        e_success "Initial post successfully created!"
    else
        e_warning "File already exist."
        exit 1
    fi

}



# ------------------------------------------------------------------------------
# | INITIALIZE PROGRAM                                                         |
# ------------------------------------------------------------------------------

main() {

    # Show help
    if [[ "${1}" == "-h" || "${1}" == "--help" ]]; then
        initpost_help ${1}
        exit
    fi

    # Create
    if [[ "${1}" == "-c" || "${1}" == "--create" ]]; then
        initpost_file $*
        exit
    fi

}

# Initialize
main $*
