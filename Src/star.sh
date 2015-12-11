#!/bin/bash

STAR \
	--genomeDir $3 \
	--runThreadN $4 \
	--genomeLoad NoSharedMemory \
	--readFilesCommand zcat \
	--outFileNamePrefix $5 \
	--outSAMtype BAM Unsorted \
	--readFilesIn $1 $2
