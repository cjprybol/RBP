#!/bin/bash

BASE="$( dirname "$(pwd)" )"

PASS_1_DIR="$BASE/STARpass1"
GENOME_2_DIR="$BASE/STARGenome2"

if [ ! -d "$GENOME_2_DIR" ];
        then
                mkdir "$GENOME_2_DIR"
fi

# https://code.google.com/p/rna-star/issues/attachmentText?id=7&aid=70001000&name=STAR_2pass.sh&token=2uNVZAqLYxa1oif-v4CyKumHV_M%3A1386924212945
# https://code.google.com/p/rna-star/issues/detail?id=7
cat $PASS_1_DIR/*SJ.out.tab | \
	awk 'BEGIN {OFS="\t"; strChar[0]="."; strChar[1]="+"; strChar[2]="-";} {if($5>0){print $1,$2,$3,strChar[$4]}}' | \
	sort -k1,1 -k2,2n | uniq > $GENOME_2_DIR/first_pass_joined_SJ.out.tab
