#!/bin/bash

BASE="$( dirname "$(pwd)" )"

BAM_IN="$BASE/STARpass2"
BAM_OUT="$BASE/SortedBam"
REF_DIR="$BASE/Data"

if [ ! -d "$BAM_OUT" ];
        then
                mkdir "$BAM_OUT"
fi


# https://broadinstitute.github.io/picard/explain-flags.html
# filter out:
# - read unmapped
# - mate unmapped
# - not primary alignment
# - read fails platform/vendor quality checks
# - read is PCR or optical duplicate
parallel --jobs $1 --plus \
	samtools view \
	-q 20 \
	-F 1804 \
	-buh \
	{} \
	'|' samtools sort \
	-T $BAM_OUT/'{/...}'.sort_temp \
	-O bam \
	-o $BAM_OUT/'{/...}'.sorted.filtered.bam \
	- \
	::: "$(ls "$BAM_IN"/*.Aligned.out.bam)"

parallel --jobs $1 --plus \
	samtools index {} \
	::: "$(ls $BAM_OUT/*.sorted.filtered.bam)"
