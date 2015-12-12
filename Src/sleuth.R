library(sleuth)
library(gdata)
library(biomaRt)

vignette('intro', package = 'sleuth')
# help(package = 'sleuth')
# ?sleuth_prep

# in R studio, set working directory to be that of the script!
# Menu Bar -- Session -- Set Working Directory -- To Source File Directory
base_dir <- dirname(getwd())
sample <- c("cp_7", "cp_4", "cp_8", "cp_5", "cp_12", "cp_9", "cp_13")
condition <- c("GFP", "Bel_A", "Bel_B", "Bel_C_a", "Bel_C_b", "Hlc", "SpnE")

# samples 2 conditions (from vignette)
s2c <- data.frame(sample, condition)
s2c$path <- paste(base_dir, "Kallisto", s2c$sample, sep="/")

so <- sleuth_prep(s2c, ~ condition)
