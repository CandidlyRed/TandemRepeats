library(tidyverse)
library(pROC)

old <- read_delim('~/madison/phd/Spring2024/BMI776/Final_Project/data/archive/Trost_et_al_Autism_motifs_hg19_RExPRTscores_V1.txt')
new <- read_delim('~/madison/phd/Spring2024/BMI776/Final_Project/data/Trost_et_al_Autism_motifs_hg19_RExPRTscores.txt')
labels <- read_delim('~/madison/phd/Spring2024/BMI776/Final_Project/data/Trost_et_al_Autism_motifs_hg19_labeled.txt')
labels <- labels %>% 
  mutate(id = paste(id, sampleID, sep = '_')) %>% 
  select(id, label)

old <- old %>% select(ID, SVM, XGB, contains('ensemble'))
new <- new %>% select(ID, SVM, XGB, contains('ensemble'))

new %>% arrange(ensembleBinary, ensembleScore) %>% 
  filter(lag(ensembleBinary) != ensembleBinary)

hist(new$ensembleScore)
mean(new$ensembleBinary)
mean(old$ensembleBinary)

full_data <- labels %>% inner_join(new, by = c('id' = 'ID'))

tmp <- full_data$ensembleScore
tmp <- (tmp - min(tmp)) / (max(tmp) - min(tmp))
y <- full_data$label

roc(y, tmp)
# 0.5564

roc(full_data$label, full_data$XGB)
# 0.5667
roc(full_data$label, full_data$SVM)
# 0.5692