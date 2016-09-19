#!/bin/sh

cmds=( ". ../make-toc.sh test-source.md test-output.md" ". ../make-toc.sh -s 2 test-source.md test-output.md" )

refs=( test-simple-ref.md test-skip2-ref.md )

echo ${cmds[0]}

# check whether the arrays to be looped are the same length
if [[ ${#cmds[@]} -ne ${#refs[@]}  ]]; then
    echo "cmds and refs arrays are different lengths; aborting..."
    return 1
fi

# loop the tests
for (( i=0; i < ${#cmds[@]}; i++  )); do
    echo "Test cmd: ${cmds[$i]}"
    echo "Test ref: ${refs[$i]}"
    eval "${cmds[$i]}"

    # check if the output and ref files differ
    if [[ $(cmp test-output.md "${refs[$i]}") ]]; then
        echo "Output does not match ref!"
        echo "REF:"
        cat ${refs[$i]}
        return 1
    fi
done

# clean up
rm test-output.md
