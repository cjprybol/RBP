                                                      library(sleuth)
library(gdata)
library(biomaRt)

vignette('intro', package = 'sleuth')
# help(package = 'sleuth')
# ?sleuth_prep

# in R studio, set working directory to be that of the script!
# Menu Bar -- Session -- Set Working Directory -- To Source File Directory

base_dir <- "/Users/Cameron/Box Sync/Cameron Prybol's Files/Lab/R2_Li/RBP"
# base_dir <- dirname(getwd())
# sample <- c("cp_7", "cp_4", "cp_8", "cp_5", "cp_12", "cp_9", "cp_13")
# condition <- c("GFP", "Bel_A", "Bel_B", "Bel_C_a", "Bel_C_b", "Hlc", "SpnE")

# replicates are required, so let's just double them, and change the Bels to all be Bel

sample <- c("cp_7", "cp_7", "cp_4", "cp_8", "cp_5", "cp_12", "cp_9", "cp_9", "cp_13", "cp_13")
path <- paste(base_dir, "Kallisto", sample, sep="/")

# now make them "unique"
sample <- c("cp_7a", "cp_7b", "cp_4", "cp_8", "cp_5", "cp_12", "cp_9a", "cp_9b", "cp_13a", "cp_13b")
# try this if the above doesn't work
# sample <- c("GFPa", "GFPb", "Bel1a", "Bel1b", "Bel2a", "Bel2b", "Hlca", "Hlcb", "SpnEa", "SpnEb")
condition <- c("control", "control", "Bel_KD_1", "Bel_KD_1", "Bel_KD_2", "Bel_KD_2", "Hlc_KD", "Hlc_KD", "SpnE_KD", "SpnE_KD")

# samples 2 conditions (from vignette)
s2c <- data.frame(sample, condition)
# add seperately so it's not converted to a factor
s2c$path <- path

t2g_path <- paste(dirname(getwd()), "Data", "mart_export.txt", sep="/")
t2g <- read.csv(paste(dirname(getwd()), "Data", "mart_export.txt", sep="/"), header=TRUE, sep = "\t")
t2g <- dplyr::rename(t2g, target_id = Ensembl.Transcript.ID, ens_gene = Ensembl.Gene.ID)
head(t2g)

name2gene_id <- data.frame(gene_name=c("bel", "Hlc", "SpnE"), gene_id=c("FBgn0000171", "FBgn0001565", "FBgn0003483"))

so <- sleuth_prep(s2c, ~ condition, target_mapping = t2g)
so <- sleuth_fit(so)
so <- sleuth_wt(so, 'conditioncontrol')

sleuth_live(so)
results_table <- sleuth_results(so, 'conditioncontrol')

head(results_table)

# 2 non paired bel KD
plot_scatter(so, sample_x = s2c$sample[3], sample_y = s2c$sample[4])
# same bel KD
plot_scatter(so, sample_x = s2c$sample[5], sample_y = s2c$sample[6])

plot_volcano(so)
