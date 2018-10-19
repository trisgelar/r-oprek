getwd()
setwd("E:/Projects/Workshop/r-oprek")

??tidyr
install.packages("tidyverse")
library(tidyverse)
library(tidyr)
library(dplyr)
library(ggplot2)

# tidying: structuring datasets to facilitate analysis.

preg <- read.csv("data/preg.csv", stringsAsFactors = FALSE)

preg2 <- read.csv("data/preg2.csv", stringsAsFactors = FALSE)

preg3 <- preg %>% 
  gather(treatment, n, treatmenta:treatmentb) %>% 
  mutate(treatment = gsub("treatment", "", treatment)) %>% 
  arrange(name, treatment)
  
preg3

pew <- tbl_df(read.csv("data/pew.csv", stringsAsFactors = FALSE, check.names = FALSE))
pew2 <- pew %>% 
  gather(income, frequency, -religion)

billboard <- tbl_df(read.csv("data/billboard.csv", stringsAsFactors = FALSE))
billboard2 <- billboard %>% 
  gather(week, rank, wk1:wk76, na.rm = TRUE)

billboard3 <- billboard2 %>% 
  mutate(
    week = readr::parse_number(week),
    date = as.Date(date.entered) + 7 * (week - 1)
  ) %>% 
  select(-date.entered)

billboard3 %>% arrange(artist, track, week)
billboard3 %>% arrange(date, rank)

tb_data <-  tbl_df(read.csv("data/tb.csv", stringsAsFactors = FALSE))

tb_data2 <- tb_data %>% 
  gather(demo, n, -iso2, -year, na.rm = TRUE)

tb_data3 <- tb_data2 %>% 
  separate(demo, c("sex", "age"),1)

w_data <- tbl_df(read.csv("data/weather.csv", stringsAsFactors = FALSE))
w_data_2 <- w_data %>% 
  gather(day, value, d1:d31, na.rm = TRUE)

w_data_2

w_data_3 <- w_data_2 %>% 
  mutate(day = readr::parse_number(day)) %>% 
  select(id, year, month, day, element, value) %>% 
  arrange(id, year, month, day)

w_data_3 %>% spread(element, value)

song <- billboard3 %>% 
  select(artist, track, year, time) %>% 
  unique() %>% 
  mutate(song_id = row_number())
song

rank <- billboard3 %>% 
  left_join(song, c("artist", "track", "year", "time")) %>% 
  select(song_id, date, week, rank) %>% 
  arrange(song_id, date)
rank

table1
table2
table3
table4a
table4b

table1 %>% 
  mutate(rate = cases / population * 10000)

table1 %>% 
  count(year, wt = cases)

ggplot(table1, aes(year,cases)) +
  geom_line(aes(group = country), colour = "grey50") +
  geom_point(aes(colour = country))

if(FALSE){
  "untidy problem  
  One variable might be spread across multiple columns.
  One observation might be scattered across multiple rows."
}

tidy4a <- table4a %>% 
  gather(`1999`, `2000`, key= "year", value="cases")

tidy4b <- table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")

# combine two tidy data to tibble

tidy4 <- left_join(tidy4a, tidy4b)
tidy4

tidy2 <- table2 %>% 
  spread(key = type, value = count)
tidy2

stocks <- tibble(
  year = c(2015, 2015, 2016, 2016),
  half = c(1,2,1,2),
  return = c(1.88, 0.59, 0.92, 0.17)
)

stocks %>% 
  spread(key=year, value=return) %>% 
  gather("year", "return", `2015`, `2016`)

table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")

people <- tribble(
  ~name,             ~key,    ~value,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)

preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)

preg %>%
  gather("male", "female", key=gender, value = count)

table3 %>%
  separate(rate, into = c("cases", "population"), sep = "/", convert = TRUE)

table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)

table5 %>% 
  unite(new, century, year, sep="")


stocks <- tibble(
  year = c(2015,2015,2015,2015,2016,2016, 2016),
  qtr = c(1, 2, 3, 4, 2, 3, 4),
  return = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66)
)

stocks %>% 
  spread(year, return) %>% 
  gather(year, return, `2015`, `2016`, na.rm = TRUE)

stocks %>% 
  complete(year, qtr)

treatment <- tribble(
  ~ person,           ~ treatment, ~response,
  "Derrick Whitmore", 1,           7,
  NA,                 2,           10,
  NA,                 3,           9,
  "Katherine Burke",  1,           4
)

treatment %>% 
  fill(person)

who1 <- who %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)
who1

who1 %>% 
  count(key)

who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))

who2

who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")

who3

who3 %>%
  count(new)

who4 <- who3 %>% 
  select(-new, -iso2, -iso3)

who4

who5 <- who4 %>% 
  separate(sexage, c("sex", "age"), sep = 1)
who5

who %>%
  gather(key, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel")) %>%
  separate(key, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)


rm(list=ls())