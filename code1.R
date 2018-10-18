# Code 1: Belajar dplyr

getwd()
setwd("E:/Projects/Workshop/r-oprek")

install.packages("dplyr")
install.packages("rvest")
install.packages("httr")
install.packages("shiny")
install.packages("leaflet")
install.packages("ggplot2")
install.packages("tidyr")
install.packages("readr")
install.packages("tibble")
install.packages("stringr")
install.packages("forcats")
install.packages("magrittr")
install.packages("glue")
install.packages("broom")
install.packages("recipes")
install.packages("plotly")

# Read Documentation / help
if(FALSE){
  "
  ? / ?? vignates() / browseVignattes()
  help.search()
  RSiteSearch()
  demo(package = 'library')
  demos
  "
}

install.packages("nycflights13")
library(nycflights13)
dim(flights)

flights

# convert dataframe to tibble as_tibble()
if(FALSE){
  "
  filter() to select cases based on their values.
  arrange() to reorder the cases.
  select() and rename() to select variables based on their names.
  mutate() and transmute() to add new variables that are functions of existing variables.
  summarise() to condense multiple values to a single value.
  sample_n() and sample_frac() to take random samples.
  "
}
library(dplyr)
library(ggplot2)

flights
filter(flights, month == 1, day == 1)
flights[flights$month == 1 & flights$day == 1, ]

arrange(flights, year, month, day)
arrange(flights, desc(arr_delay))

select(flights, year, month, day)
select(flights, year:day)
select(flights, -(year:day))

if(FALSE){
  "
    select helpers: starts_with(), ends_with(), 
    matches(), contains()
  "
}

mutate(flights, 
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60,
       gain_per_hour = gain / (air_time / 60)
       )

transmute(flights, 
          gain = arr_delay - dep_delay,
          gain_per_hour = gain / (air_time / 60)
          )
dim(flights)

sample_n(flights, 10)
sample_frac(flights, 0.01)

summarise(flights, 
          delay = mean(dep_delay, na.rm = TRUE)
          )
if(FALSE){
  "
  aggregate functions: min(), max(), mean(), sum(), sd(), median(), and IQR()
  n(): the number of observations in the current group
  n_distinct(x):the number of unique values in x.
  first(x), last(x) and 
  nth(x, n) - these work similarly to x[1], x[length(x)], and x[n] but give you more control over the result if the value is missing.
  "
}
by_tailnum = group_by(flights, tailnum)
delay = summarise(
  by_tailnum,
  count = n(),
  dist = mean(distance, na.rm = TRUE),
  delay = mean(arr_delay, na.rm = TRUE)
  )
delay = filter(delay, count > 20, dist < 2000)

ggplot(delay, aes(dist, delay)) +
  geom_point(aes(size=count), alpha=1/2) +
  geom_smooth() +
  scale_size_area()

destinations = group_by(flights, dest)
summarise(destinations,
          planes = n_distinct(tailnum),
          flights = n()
          )

daily = group_by(flights, year, month, day)
(per_day = summarise(daily, flights = n()))
(per_month = summarise(per_day, flights = sum(flights)))
(per_year = summarise(per_month, flights = sum(flights)))

vars = c("year", "month")
select(flights, vars, "day")

flights$vars = flights$year
select(flights, !! vars, "day")

df = select(flights, year:dep_time)

mutate(df, "year", 2)

mutate(df, year + 10)

var = seq(1, nrow(df))
mutate(df, new = var)

group_by(df, month)
group_by(df, month = as.factor(month))
group_by(df, day_binned = cut(day, 3))

??cut

group_by(df, "month")
group_by_at(df, vars(year:day))

?scoped

a1 = group_by(flights, year, month, day)
a2 = select(a1, arr_delay, dep_delay)
a3 = summarise(a2,
               arr = mean(arr_delay, na.rm = TRUE),
               dep = mean(dep_delay, na.rm = TRUE)
               )
a4 = filter(a3, arr > 30 | dep > 30)

flights %>%
  group_by(year, month, day) %>%
  select(arr_delay, dep_delay) %>%
  summarise(
    arr = mean(arr_delay, na.rm = TRUE),
    dep = mean(dep_delay, na.rm = TRUE)
  ) %>%
  filter(arr > 30 | dep > 30)

# vignette("window-functions")
# vignette("programming")
# vignette("dbplyr")

rm(list=ls())