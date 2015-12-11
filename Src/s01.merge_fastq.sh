#!/bin/bash

BASE="$( dirname "$(pwd)" )"

IN_DIR="$BASE/Data/FastQ"
OUT_DIR="$BASE/FastqCombined"

if [ ! -d "$OUT_DIR" ];
        then
                mkdir "$OUT_DIR"
fi

# find directories that start with cp_
for i in $(find -L "$IN_DIR" -type d -name "cp_*"); do
    for j in "1" "2"; do
        pre=$(basename $i | cut -d '-' -f1)
        cat $(find -L $i -type f -name "*_R"$j"_001.fastq.gz") > "$OUT_DIR/$pre.$j.fastq.gz"
    done
done
