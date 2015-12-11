#!/bin/bash

BASE="$( dirname "$(pwd)" )"

GENOME_2_DIR="$BASE/STARGenome2"
REFERENCE_DIR="$BASE/Data"

READ_LEN=76

# generate genome
# --sjdbOverhang = readlen -1
STAR \
	--runMode genomeGenerate \
	--genomeDir $GENOME_2_DIR \
	--genomeFastaFiles "$REFERENCE_DIR/Homo_sapiens.GRCh38.dna.fa" \
	--sjdbOverhang $((READ_LEN-1)) \
	--sjdbGTFfile "$REFERENCE_DIR/Homo_sapiens.GRCh38.82.gtf" \
	--sjdbFileChrStartEnd "$GENOME_2_DIR/first_pass_joined_SJ.out.tab" \
	--runThreadN $1 \
	--outFileNamePrefix "$GENOME_2_DIR/"
