library(tidyverse)

tibble(x = letters)

tibble(x = 1:3, y = list(1:5, 1:10, 1:20))
quo(tibble(x = !! 1:3, y = !! list(1:5, 1:10, 1:20)))

names(data.frame(`crazy name` = 1))
names(tibble(`crazy name` = 1))

tibble(x = 1:5, y = x ^ 2)
tibble(x = 1:5, y = x ^ 2 + x + 1)

data.frame(x = 1:10000)

tibble(x = 1:10000)

# options(tibble.print_max = n, tibble.print_min = m)
# options(tibble.print_max = Inf)
# options(tibble.width = Inf)

df1 <- data.frame(x = 1:3, y = 3:1)
class(df1[, 1:2])
class(df1[, 1])

df2 <- tibble(x = 1:3, y = 3:1)
class(df2[, 1:2])
class(df2[, 1])

class(df2[[1]])
class(df2$x)

df <- data.frame(abc = 1)
df$a

df2 <- tibble(abc = 1)
df2$abc

data.frame(a = 1:3)[, "a", drop = TRUE]
tibble(a = 1:3)[, "a", drop = TRUE]

tibble(a = 1, b = 1:3)
tibble(a = 1:3, b = 1)

tibble(a = 1:3, c = 1:2)
tibble(a = 1, b = integer())
tibble(a = integer(), b = 1)

class(iris)
class(as_tibble(iris))

tibble(
  x = 1:5,
  y = 1,
  z = x ^ 2 + y
)

# backtick
tb <- tibble(
  `:)` = "smile",
  ` `  = "space",
  `2000` = "number"
)
tb

tribble(
  ~x, ~y, ~z,
  #--/--/----
  "a",2, 3.6,
  "b",1, 8.5
)

tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE)
)

nycflights13::flights %>% 
  print(n = 10, width = Inf)

package(tibble)

nycflights13::flights %>% 
  View()

df <- tibble(
  x = runif(5),
  y = rnorm(5)
)

df$x
df[['x']]
df[[1]]

df %>% .$x
df %>% .[["x"]]

mtidy <- mtcars %>% 
  as_tibble()

class(mtidy)
mtidy$mpg


rm(list=ls())