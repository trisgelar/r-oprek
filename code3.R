getwd()
setwd("E:/Projects/Workshop/r-oprek")

??tidyr
library(tidyr)
library(dplyr)

# tidying: structuring datasets to facilitate analysis.

preg <- read.csv("data/preg.csv", stringsAsFactors = FALSE)

preg2 <- read.csv("data/preg2.csv", stringsAsFactors = FALSE)

preg3 <- preg %>% 
  gather(treatment, n, treatmenta:treatmentb) %>% 
  mutate(treatment = gsub("treatment", "", treatment)) %>% 
  arrange(name, treatment)
  
preg3



rm(list=ls())