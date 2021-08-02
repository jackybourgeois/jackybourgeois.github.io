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
echo "categories: [Notes,Literature]"
echo "tags: []"
echo "context: \"\""
echo "backlinks: []"
echo "---"
echo ""
echo "# Initial interest"
echo "__is it worth of interest? Potential connection? New horizon?__"
echo ""
echo "[ ] PDF"
echo "[ ] Bibtex"
echo ""
echo "[ ] Context: __how did I find this paper, what was I looking for, connection to interests?__"
echo ""
echo "# Fleeting Notes"
echo "__Is this convincing? What methods do they use? Which of the references are familiar?__"
echo ""
echo "# Rephrased contribution, method and novelty"
echo ""
echo "1. __Write it in your own words__"
echo "2. __Write it in such away that if you read it 10 years later it would make complete sense by itself.__"
echo "3. __One idea per note. If you need to define a term for the idea/concept to make sense, create a term definition card and link to it from the concept note.__"
echo ""
echo "[ ] __Add tags__"
echo ""
echo "- __What does this all mean for my own research and the questions I think about in my slip-box?__"
echo "- __Why did the aspects I wrote down catch my interest?__"
echo "- __How does it add, correct?__"
echo ""
echo "[ ] __Does it connect to my work? For each connection, create an idea...md and add links__"
echo ""
echo "[ ] __Commit__"
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
