#!/bin/bash

cmds=(
"" # default
"-s 2" # skip 2
"-d 1" # depth 1
"-d 2"
"-d 3"
"-s 2 -d 2" # multi-flag
)

refs=(
./test/simple-ref.md
./test/skip2-ref.md
./test/depth1-ref.md
./test/depth2-ref.md
./test/depth3-ref.md
./test/multiflag-ref.md
)

echo ${cmds[0]}

# check whether the arrays to be looped are the same length
if [ ${#cmds[@]} -ne ${#refs[@]}  ]; then
    echo "cmds and refs arrays are different lengths; aborting..."
    return 1
fi

# loop the tests
cd .. # run from the root dir
for (( i=0; i < ${#cmds[@]}; i=i+1 )); do
    echo "--------------------------------------------------------"
    echo "Test cmd: ${cmds[$i]}"
    echo "Test ref: ${refs[$i]}"
    echo "--------------------------------------------------------"
    eval ". ./make-toc.sh ${cmds[$i]} ./test/test-source.md ./test/test-output.md"

    # check if the output and ref files differ
    DIFF=$(cmp ./test/test-output.md ${refs[$i]})
    if [[ -n $DIFF ]]; then
        printf "\nDIFF: $DIFF\n"
        printf "\nEXPECTED:\n"
        cat ${refs[$i]}

        printf "\nACTUAL:\n"
        mv ./test/test-output.md ./test/test-output-fail.md # rename to signify fail
        cat ./test/test-output-fail.md

        printf "*************\n"
        printf "FAIL: Output does not match ref!\n"
        printf "*************\n\n"
    else
        printf "*************\n"
        printf "PASS\n"
        printf "*************\n\n"
        rm ./test/test-output.md # clean up
    fi
done

cd ./test # cd back into test dir on finish
