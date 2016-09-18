#!/usr/bin/env bash

# This script generates a tiered Table of Contents from a
# markdown document's header tags.

# The number of CLI args passed
ARGNUM=$#

# DEFAULTS
# Input .md file; e.g. README.md
INPUT=$1
# Output .md file to write to; e.g. TOC.md
OUTPUT=$2
# Amount of headers to skip from top of file; e.g. the file's title
SKIP=0

if [[ $ARGNUM -gt 2  ]]; then
    case "$1" in
        -s|--skip)
            SKIP=$(( $2 + 1  )) # the skip + offset
            INPUT=$3
            OUTPUT=$4
            ;;
    esac
fi


function generateTree {
    # Turn headers into top-level bullet points
    sed -i 's/^## /- /' $1

    # Turn subheaders into 2nd level bullet points
    sed -i 's/^#### /    - /' $1
}


# The ToC generator
function makeToc {
    # Pull out all the header tags
    # then trim the first two lines (i.e. repo name & `## Contents` itself)
    # then write to filename passed as $OUTPUT
    grep -E "^\#+ [A-Za-z]+ ?[A-Za-z]*" $INPUT|tail -n+$SKIP > $OUTPUT

    generateTree $OUTPUT

    # Turn each point into a markdown link
    sed -i -r "s/(\- )([A-Za-z]+ ?[A-Za-z]*)/\1[\2](#\2)/" $OUTPUT

    # Replace spaces in anchor links with hyphens
    sed -i -r "s/\((#[A-Za-z]+) ([A-Za-z]+)\)$/(\1-\2)/" $OUTPUT

    # Set all anchor tags to lowercase to link properly
    sed -i -r 's/(\(#[A-Za-z]+-?[A-Za-z]+\)$)/\L\1/' $OUTPUT

    # Log the final result written to $OUTPUT
    cat $OUTPUT
}


# Are we on a GNU distro?
# If not is there a `gsed` manual? Otherwise does the `sed` manual reference GNU?
# Inform user that we need `gsed` if we find none of these, otherwise run the formatting script.
sedcheck=$(man sed)
gsedcheck=$(man gsed)
oscheck=$(uname)

if [[ ! $oscheck =~ .*linux-gnu.*  ]] && [[ ! $gsedcheck =~ .*GNU.*   ]] && [[ ! $sedcheck =~ .*GNU.* ]]
then
    echo "Oops! Seems like you don't have gsed (GNU sed) installed (ಠ_ಠ)"
    echo "If you're on OSX and use homebrew, try:"
    echo "'brew install gnu-sed'"
    echo "Then rerun this script ( ＾▽＾  )っ"
    return 1
else
    makeToc
    return 0
fi
