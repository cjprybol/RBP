#!/bin/bash

BASE="$( dirname "$(pwd)" )"

OUT_DIR="$BASE/Kallisto"

# if output folder does not exist, create it
if [ ! -d "$OUT_DIR" ];
        then
                mkdir "$OUT_DIR"
fi

kallisto index --make-unique --index=$OUT_DIR/index $BASE/Data/dm6.cdna.fa
