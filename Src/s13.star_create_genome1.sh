#!/bin/bash

BASE="$( dirname "$(pwd)" )"

GENOME_1_DIR="$BASE/STARGenome1"
REFERENCE_DIR="$BASE/Data"

READ_LEN=76

# if output folder does not exist, create it
if [ ! -d "$GENOME_1_DIR" ];
        then
                mkdir "$GENOME_1_DIR"
fi

# generate genome
# --sjdbOverhang = readlen -1
STAR \
	--runMode genomeGenerate \
	--runThreadN $1 \
	--genomeDir $GENOME_1_DIR \
	--genomeFastaFiles "$REFERENCE_DIR/Drosophila_melanogaster.BDGP6.dna.toplevel.fa" \
	--sjdbOverhang $((READ_LEN-1)) \
	--sjdbGTFfile "$REFERENCE_DIR/Drosophila_melanogaster.BDGP6.83.gtf" \
	--outFileNamePrefix "$GENOME_1_DIR/"
