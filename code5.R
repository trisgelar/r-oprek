library(tidyverse)
library(readr)

heights <- read_csv("data/heights.csv")
class(heights)

read_csv("a,b,c
1,2,3
4,5,6")

# skip = 2

read_csv("# Acommnet I want to skip
x,y,z
1,2,3", comment = "#")

read_csv("1,2,3\n4,5,6", col_names = c("x", "y", "z"))
read_csv("a,b,c\n1,2,.", na = ".")

str(parse_logical(c("TRUE", "FALSE", "NA")))
str(parse_integer(c("1","2","3")))
str(parse_date(c("2010-01-01", "1979-10-14")))

parse_integer(c("1", "231", ".", "456"), na = ".")
x <- parse_integer(c("123", "345", "abc", "123.45"))

x
problems(x)

parse_double("1.23")
parse_double("1,23", locale = locale(decimal_mark = ","))
parse_number("$100")
parse_number("20%")
parse_number("It cost $123.45")

parse_number("$123,456,789")
parse_number("$123,456,789", locale = locale(grouping_mark = "."))
parse_number("123'456'789", locale = locale(grouping_mark = "'"))

charToRaw("Hadley")

x1 <- "El Ni\xf1o was particularly bad this year"
x2 <- "\x82\xb1\x82\xf1\x82\xc9\x82\xbf\x82\xcd"

parse_character(x1, locale = locale(encoding = "Latin1"))
parse_character(x2, locale = locale(encoding = "Shift-JIS"))

guess_encoding(charToRaw(x1))
guess_encoding(charToRaw(x2))

fruit <- c("apple", "banana")
parse_factor(c("apple", "banana", "bananana"), levels = fruit)

parse_datetime("2010-10-01T2010")
parse_datetime("20101001")
parse_date("2010-10-01")

library(hms)
parse_time("01:10 am")

parse_date("01/02/15", "%m/%d/%y")

parse_date("1 janvier 2015", "%d %B %Y", locale = locale("fr"))

