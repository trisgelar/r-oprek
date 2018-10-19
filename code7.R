library(tidyverse)
library(stringr)

string1 <- "This is a string"
string2 <- 'If I want to include a "quote" inside a string, I use single quotes'

double_quote <- "\"" # or '"'
single_quote <- '\'' # or "'"

x <- c("\"", "\\")
x

writeLines(x)

str_length(c("a", "R for data science", NA))

str_c("x", "y")
str_c("x", "y", "z")
str_c("x", "y", sep = ", ")

x <- c("abc", NA)
str_c("|-", x,"-|")
str_c("|-", replace_na(x), "-|")

str_c("prefix-", c("a", "b", "c"), "-suffix")

name <- "Hadley"
time_of_day <- "morning"
birthday <- FALSE

str_c(
  "Good ", time_of_day, " ", name,
  if (birthday) " and HAPPY BIRTHDAY",
  "."
)

str_c(c("x", "y", "z"), collapse = ", ")

x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
str_sub(x, -3, -1)
str_sub("a", 1, 5)
str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))
x

x <- c("apple", "banana", "pear")
str_view(x, "an")
y <- str_view(x, ".a.")

x <- c("apple", "banana", "pear")
str_view(x, "^a")

x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, "CC?")
str_view(x, "CC+")
str_view(x, 'C[LX]+')
str_view(x, "C{2}")
str_view(x, "C{2,}")
str_view(x, "C{2,3}")
str_view(x, 'C{2,3}?')
str_view(x, 'C[LX]+?')

str_view(fruit, "(..)\\1", match = TRUE)

x <- c("apple", "banana", "pear")
str_detect(x, "e")

sum(str_detect(words, "^t"))

str_length("abc")

x <- c("abcdef", "ghijk")

str_sub(x, 3,3)
str_sub(x, 2,-2)

str_sub(x, 3,3) <- "X"
x

str_dup(x, c(2,3))

x <- c("abc", "defghi")
str_pad(x, 10)
str_pad(x, 10, "both")

str_pad(x,4)

x <- c("Short", "This is a long string")
x %>% 
  str_trunc(10) %>% 
  str_pad(10, "right")

x <- c("  a   ", "b   ",  "   c")
str_trim(x, "left")

jabberwocky <- str_c(
  "`Twas brillig, and the slithy toves ",
  "did gyre and gimble in the wabe: ",
  "All mimsy were the borogoves, ",
  "and the mome raths outgrabe. "
)

cat(str_wrap(jabberwocky, width = 40))

x <- "I like horses."
str_to_upper(x)
str_to_title(x)
str_to_lower(x)
str_to_lower(x, "tr")

x <- c("y", "i", "k")
str_order(x)
str_sort(x)


strings <- c(
  "apple", 
  "219 733 8965", 
  "329-293-8753", 
  "Work: 579-499-7527; Home: 543.355.3679"
)
phone <- "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})"
phone

str_detect(strings, phone)
str_subset(strings, phone)
str_count(strings, phone)

(loc <- str_locate(strings, phone))
str_locate_all(strings, phone)

str_extract(strings, phone)
str_extract_all(strings, phone)

str_extract_all(strings, phone, simplify = TRUE)
str_match(strings, phone)
str_match_all(strings, phone)
str_replace(strings, phone, "XXX-XXX-XXXX")
str_replace_all(strings, phone, "XXX-XXX-XXXX")

str_split("a-b-c", "-")
str_split_fixed("a-b-c", "-", n = 2)


# vignette("regular-expressions").
x <- c("apple", "banana", "pear")
str_extract(x, "an")
bananas <- c("banana", "Banana", "BANANA")
str_detect(bananas, "banana")
str_detect(bananas, regex("banana", ignore_case = TRUE))

str_extract(x, ".a.")

str_detect("\nX\n", ".X.")
str_detect("\nX\n", regex(".X.", dotall = TRUE))

dot <- "\\."
writeLines(dot)
str_extract(c("abc", "a.c", "bef"), "a\\.c")

x <- "a\\b"
writeLines(x)

str_extract(x, "\\\\")
x <- c("a.b.c.d", "aeb")
starts_with <- "a.b"

str_detect(x, paste0("^", starts_with))
str_detect(x, paste0("^\\Q", starts_with, "\\E"))

if(FALSE){
"
  Escapes also allow you to specify individual characters that are otherwise hard to type. You can specify individual unicode characters in five ways, either as a variable number of hex digits (four is most common), or by name:
  \xhh: 2 hex digits.
  \x{hhhh}: 1-6 hex digits.
  \uhhhh: 4 hex digits.
  \Uhhhhhhhh: 8 hex digits.
  \N{name}, e.g. \N{grinning face} matches the basic smiling emoji.
  Similarly, you can specify many common control characters:
  \a: bell.
  \cX: match a control-X character.
  \e: escape (\u001B).
  \f: form feed (\u000C).
  \n: line feed (\u000A).
  \r: carriage return (\u000D).
  \t: horizontal tabulation (\u0009).
  \0ooo match an octal character. ‘ooo’ is from one to three octal digits, from 000 to 0377. The leading zero is required.
"
}

x <- "a\u0301"
str_extract(x, ".")
str_extract(x, "\\X")

str_extract_all("1 + 2 = 3", "\\d+")[[1]]
(text <- "Some  \t badly\n\t\tspaced \f text")
str_replace_all(text, "\\s+", " ")

(text <- c('"Double quotes"', "«Guillemet»", "“Fancy quotes”"))
str_replace_all(text, "\\p{quotation mark}", "'")

str_extract_all("Don't eat that!", "\\w+")[[1]]
str_split("Don't eat that!", "\\W")[[1]]

str_replace_all("The quick brown fox", "\\b", "_")
str_replace_all("The quick brown fox", "\\B", "_")

if(FALSE){
  "
  You can also create your own character classes using []:
  [abc]: matches a, b, or c.
  [a-z]: matches every character between a and z (in Unicode code point order).
  [^abc]: matches anything except a, b, or c.
  [\^\-]: matches ^ or -.
  There are a number of pre-built classes that you can use inside []:
  [:punct:]: punctuation.
  [:alpha:]: letters.
  [:lower:]: lowercase letters.
  [:upper:]: upperclass letters.
  [:digit:]: digits.
  [:xdigit:]: hex digits.
  [:alnum:]: letters and numbers.
  [:cntrl:]: control characters.
  [:graph:]: letters, numbers, and punctuation.
  [:print:]: letters, numbers, punctuation, and whitespace.
  [:space:]: space characters (basically equivalent to \s).
  [:blank:]: space and tab.
  "
}

str_detect(c("abc", "def", "ghi"), "abc|def")
str_extract(c("grey", "gray"), "gre|ay")
str_extract(c("grey", "gray"), "gr(e|a)y")

pattern <- "(..)\\1"
fruit %>% 
  str_subset(pattern)

fruit %>% 
  str_subset(pattern) %>% 
  str_match(pattern)

str_match(c("grey", "gray"), "gr(e|a)y")
str_match(c("grey", "gray"), "gr(?:e|a)y")

x <- c("apple", "banana", "pear")
str_extract(x, "^a")
str_extract(x, "a$")

if(FALSE){
  "
  To match a literal “$” or “^”, you need to escape them, \$, and \^.
  For multiline strings, you can use regex(multiline = TRUE). This changes the behaviour of ^ and $, and introduces three new operators:
  ^ now matches the start of each line.
  $ now matches the end of each line.
  \A matches the start of the input.
  \z matches the end of the input.
  \Z matches the end of the input, but before the final line terminator, if it exists.
  "
}

x <- "Line 1\nLine 2\nLine 3\n"
str_extract_all(x, "^Line..")[[1]]
str_extract_all(x, regex("^Line..", multiline = TRUE))[[1]]
str_extract_all(x, regex("\\ALine..", multiline = TRUE))[[1]]

if(FALSE){
  "
  You can control how many times a pattern matches with the repetition operators:
  ?: 0 or 1.
  +: 1 or more.
  *: 0 or more.
  "
}

x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_extract(x, "CC?")
str_extract(x, "CC+")
str_extract(x, 'C[LX]+')

if(FALSE){
  "
  Note that the precedence of these operators is high, so you can write: colou?r to match either American or British spellings. That means most uses will need parentheses, like bana(na)+.
  You can also specify the number of matches precisely:
  {n}: exactly n
  {n,}: n or more
  {n,m}: between n and m
  "
}

str_extract(x, "C{2}")
str_extract(x, "C{2,}")
str_extract(x, "C{2,3}")
str_extract(x, c("C{2,3}", "C{2,3}?"))
str_extract(x, c("C[LX]+", "C[LX]+?"))

if(FALSE){
  "You can also make the matches possessive by putting a + after them, which means that if later parts of the match fail, the repetition will not be re-tried with a smaller number of characters. This is an advanced feature used to improve performance in worst-case scenarios (called “catastrophic backtracking”).
  ?+: 0 or 1, possessive.
  ++: 1 or more, possessive.
  *+: 0 or more, possessive.
  {n}+: exactly n, possessive.
  {n,}+: n or more, possessive.
  {n,m}+: between n and m, possessive."
}

str_detect("ABC", "(?>A|.B)C")
str_detect("ABC", "(?:A|.B)C")
if(FALSE){
  "
  These assertions look ahead or behind the current match without “consuming” any characters (i.e. changing the input position).
  (?=...): positive look-ahead assertion. Matches if ... matches at the current input.
  (?!...): negative look-ahead assertion. Matches if ... does not match at the current input.
  (?<=...): positive look-behind assertion. Matches if ... matches text preceding the current position, with the last character of the match being the character just before the current position. Length must be bounded
  (i.e. no * or +).
  (?<!...): negative look-behind assertion. Matches if ... does not match text preceding the current position. Length must be bounded
  (i.e. no * or +).
  "
}

x <- c("1 piece", "2 pieces", "3")
str_extract(x, "\\d+(?= pieces?)")
y <- c("100", "$400")
str_extract(y, "(?<=\\$)\\d+")


str_detect("xyz", "x(?#this is a comment)")

phone <- regex("
  \\(?     # optional opening parens
               (\\d{3}) # area code
               [)- ]?   # optional closing parens, dash, or space
               (\\d{3}) # another three numbers
               [ -]?    # optional space or dash
               (\\d{3}) # three more numbers
               ", comments = TRUE)

str_match("514-791-8141", phone)

















rm(list=ls())