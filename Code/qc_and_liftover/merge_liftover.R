## after doing liftover using UCSC's liftover tool, merge liftover back in
library(data.table)
library(dplyr)

# read in motifs file and format in liftover style
df <- fread("/Users/stephen/Mirror/BMI_776/project/Raw_Data/Raw_Autism_motifs.txt")
chr_start_end <- paste(df$chr, ":", df$start, "-", df$end, sep="")
write.table(chr_start_end, "./liftover.txt", col.names = F, row.names = F, sep = "\n", quote = F)
df$chr_start_end <- chr_start_end

## after this step use UCSC liftover tool

# read in liftover file - use clean_liftover_errors.py to format the errors file
not_liftover <- fread("/Users/stephen/Mirror/BMI_776/project/Autism/liftover_errors_clean.txt")
liftover <- fread("/Users/stephen/Mirror/BMI_776/project/Autism/hglft_genome_342c1_37c8c0.bed")

# remove entries that liftover did not work for
motifs_clean <- anti_join(df, not_liftover, by = "chr_start_end")

# get hg38 codes from liftover file by joining columns
motifs_clean <- cbind(motifs_clean, liftover)

# Splitting the vector by ":", "-" or another "-"
split_v <- strsplit(motifs_clean$hg19, "[:-]", perl=TRUE)

# Extracting chromosomes, start, and end positions into separate vectors
chr <- sapply(split_v, function(x) x[1])
start <- sapply(split_v, function(x) x[2])
end <- sapply(split_v, function(x) x[3])

# write over chr, start, and end columns
motifs_clean$chr <- chr
motifs_clean$start <- start
motifs_clean$end <- end

write.table(motifs_clean, "/Users/stephen/Mirror/BMI_776/project/Raw_Data/Raw_Autism_motifs_hg19.txt", col.names = T, row.names = F, sep = "\t", quote = F)
