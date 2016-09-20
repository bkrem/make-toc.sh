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
    echo "--------------------------------------------------------"
    echo "Test cmd: ${cmds[$i]}"
    echo "Test ref: ${refs[$i]}"
    echo "--------------------------------------------------------"
    eval "${cmds[$i]}"

    # check if the output and ref files differ
    if [[ $(cmp test-output.md "${refs[$i]}") ]]; then
        printf "\nEXPECTED:\n"
        cat ${refs[$i]}

        printf "\nACTUAL:\n"
        mv test-output.md test-output-fail.md # rename to signify fail
        cat test-output-fail.md

        printf "*************\n"
        printf "FAIL: Output does not match ref!\n"
        printf "*************\n\n"
    else
        printf "*************\n"
        printf "PASS\n"
        printf "*************\n\n"
        rm test-output.md # clean up
    fi
done
