library(data.table)

df <- fread("/Users/stephen/Mirror/BMI_776/project/Raw_Data/Raw_Autism_motifs_hg19.txt")

df$label <- ifelse(is.na(df[["outliers detected"]]), 0, 1)

input <- data.frame(chr = character(), start = integer(), end = integer(), motif = character(), sampleID = integer(), label = integer(), stringsAsFactors = FALSE)

for (i in 1:nrow(df)) {
    row <- df[i]

    motifs <- strsplit(row[["list of motifs"]], ";")[[1]]

    label <- i
    
    input_rows <- data.frame(chr = character(), start = integer(), end = integer(), motif = character(), sampleID = integer(), label = integer(), stringsAsFactors = FALSE)
    for (j in 1:length(motifs)) {
        motif <- motifs[j]
        input_row <- data.frame(chr = row$chr, start = row$start, end = row$end, motif = motif, sampleID = 1, label = row$label, stringsAsFactors = FALSE)

        input_rows <- rbind(input_rows, input_row)
    }

    input <- rbind(input, input_rows)
}

nrow(df)
nrow(input)

fwrite(input, "./Trost_et_al_Autism_motifs_hg19_labeled.txt", col.names=T, row.names=F, sep="\t", quote=F)
