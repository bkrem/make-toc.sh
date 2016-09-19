#!/bin/sh

# This script generates a nested Table of Contents from a
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
            SKIP=$(( $2 + 1 )) # the skip + offset
            INPUT=$3
            OUTPUT=$4
            ;;
    esac
fi


# Detects the top level header type and generates a hierarchical
# list of bullet points relative to the top level.
# $1 - A list of markdown headers
function generateTree {
    HEADERS=$1
    # Log the file -> get first line -> isolate the header tag
    TL=$( cat $HEADERS|head -1|sed -r "s/(#+) (.+)/\1/" )
    SIZE=${#TL}
    INDENT="-"

    echo "Top level header: ${TL}"

    while [ $SIZE -lt 5  ]; do
        sed -i "s/^$TL /$INDENT /" $HEADERS
        TL="$TL#"
        INDENT="    $INDENT"
        let SIZE=SIZE+1
    done
}


# The ToC generator
function makeToc {
    # Pull out all the header tags
    # then trim the first two lines (i.e. repo name & `## Contents` itself)
    # then write to filename passed as $OUTPUT
    grep -E "^\#+ .+" $INPUT|tail -n+$SKIP > $OUTPUT

    generateTree $OUTPUT

    # Turn each point into a markdown link
    sed -i -r "s/(\- )([A-Za-z]+ ?[A-Za-z]*)/\1[\2](#\2)/" $OUTPUT

    # Replace spaces in anchor links with hyphens
    sed -i -r "s/\((#[A-Za-z]+) ([A-Za-z]+)\)$/(\1-\2)/" $OUTPUT

    # Set all anchor tags to lowercase to link properly
    sed -i -r 's/(\(#[A-Za-z\-]+\)$)/\L\1/' $OUTPUT

    # Log the final result written to $OUTPUT
    cat $OUTPUT
}


# Are we on a GNU distro?
# If not, is this the GNU version of `sed`?
# Inform user that we need `gsed` if we find none of these, otherwise run the formatting script.
sedcheck=$(sed --version)
oscheck=$(uname)

if [[ ! $oscheck =~ .*linux-gnu.*  ]] && [[ ! $sedcheck =~ .*GNU.* ]]
then
    echo "Oops! Seems like you don't have gnu-sed (GNU sed) installed (ಠ_ಠ)"
    echo "If you're on OSX and use homebrew, try:"
    echo "'brew install gnu-sed --with-default-names'"
    echo "Then rerun this script ( ＾▽＾  )っ"
    return 1
else
    makeToc
    return 0
fi
