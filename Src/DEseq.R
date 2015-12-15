library(DESeq2)
library(gdata)

# in R studio, set working directory to be that of the script!
# Menu Bar -- Session -- Set Working Directory -- To Source File Directory

# use these when working with the cluster directories, remember to drop CP_8!
# base_dir <- dirname(getwd())
# counts_dir <- paste(base_dir, "HTseqCounts", sep="/")





# cp_8 not used
counts_dir <- "~/Box Sync/Cameron Prybol's Files/Lab/R2_Li/RBP/HTseqCounts"
files <- dir(counts_dir)[grepl("*.counts", dir(counts_dir))]

countData <- read.csv(paste(counts_dir, files[1], sep="/"), sep="\t", header = FALSE)
for (file in files[-1]){
  temp <- read.csv(paste(counts_dir, file, sep="/"), sep="\t", header = FALSE)
  countData <- merge(countData, temp, by="V1")
}

# have all of the data, now drop the first 5 rows which are
# __alignment_not_unique __ambiguous            __no_feature           __not_aligned          __too_low_aQual

countData <- countData[-seq(1,5), ]
colnames(countData) <- c("gene", files)
rownames(countData) <- countData$gene
countData <- countData[,-1]


# now we have the data how we want it, but we need to subset
# DEseq only cares about the difference between "treated" and "untreated"
# we have several treated vs untreated groups, so look at each individually

# file mapping sample IDs to genes
associations <- read.csv(paste(counts_dir, "association.tsv", sep="/"), sep="\t", header = TRUE, stringsAsFactors = FALSE)

genes <- unique(associations$gene)
notGFP <- genes[!grepl("GFP", genes)]

g <- notGFP[1] # Bel
# untreated = GFP plus all non treated for that gene
untreated <- associations[!associations$gene == g, ]$sample
treated <- associations[associations$gene == g, ]$sample

this_id <- associations[associations$gene == g,]$id[1]

columns_to_keep <- c(untreated, treated)
columns_to_keep <- paste(columns_to_keep, "counts", sep=".")
# this reorders the data
countDataSub <- countData[columns_to_keep]

conditions <- c(rep("untreated", length(untreated)), rep("treated", length(treated)))
colData <- data.frame(condition = conditions)
rownames(colData) <- colnames(countDataSub)

dds <- DESeqDataSetFromMatrix(countData = countDataSub,
                              colData = colData,
                              design = ~ condition)
dds <- DESeq(dds)
res <- results(dds)
res <- res[complete.cases(res),]
res[this_id, ]
res <- res[order(res$padj),]
res <- res[res$padj < 0.05, ]
for (r in rownames(res)){
  print(res[r,])
}


g <- notGFP[2] # Hlc
# untreated = GFP plus all non treated for that gene
untreated <- associations[!associations$gene == g, ]$sample
treated <- associations[associations$gene == g, ]$sample

this_id <- associations[associations$gene == g,]$id[1]

columns_to_keep <- c(untreated, treated)
columns_to_keep <- paste(columns_to_keep, "counts", sep=".")
# this reorders the data
countDataSub <- countData[columns_to_keep]

conditions <- c(rep("untreated", length(untreated)), rep("treated", length(treated)))
colData <- data.frame(condition = conditions)
rownames(colData) <- colnames(countDataSub)

dds <- DESeqDataSetFromMatrix(countData = countDataSub,
                              colData = colData,
                              design = ~ condition)
dds <- DESeq(dds)
res <- results(dds)
res <- res[complete.cases(res),]
res[this_id, ]
res <- res[order(res$padj),]
res <- res[res$padj < 0.05, ]
res
for (r in rownames(res)){
  print(res[r,])
}
