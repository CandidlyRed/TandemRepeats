library(tidyverse)

data <- read_delim('~/madison/phd/Spring2024/BMI776/Final_Project/data/Trost_et_al_Autism_motifs_hg19_TRsAnnotated_RExPRTscores.txt')
labels <- read_delim('~/madison/phd/Spring2024/BMI776/Final_Project/data/Trost_et_al_Autism_motifs_hg19_labeled.txt')
labels <- labels %>% 
  mutate(id = paste(id, sampleID, sep = '_')) %>% 
  select(id, label)

# Remove non-varying data
data <- data %>% select(-where(~n_distinct(.) == 1))

# Check data quality
summary(data)
data %>% 
  summarise(
    across(everything(), ~sum(is.na(.)))
  ) %>% t()

# Remove extra cols
data <- data %>% select(-c(any_of(c('chr', 'start', 'end', 'motif', 'sampleID', 'gene', 'SVM', 'XGB')), contains('ensemble')))
# Order columns
data <- data %>% select(id, everything())
# Change NA to missing and clean string
data <- data %>% mutate(gene_type = ifelse(is.na(gene_type), 'Unknown', gene_type),
                gene_type = str_remove_all(gene_type, ' ')) 

# Remove missing data with more thna 80% missing rate
data <- data[,colSums(is.na(data))<nrow(data)*0.8]

# add labels
data_label <- data %>% inner_join(labels, 'id')

# Save .csv
write_csv(data_label, '~/madison/phd/Spring2024/BMI776/Final_Project/data/TRs_annotated_cleaned.csv')
