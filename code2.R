library(dplyr)
library(glue)

greet = function(name){
  "How do you do, name?"
}

greet = function(name){
  paste0("How do you do, ", name, "?")
}

greet = function(name){
  glue::glue("How do you do {name} ?")
}
greet("Ujang")

mutate_y <- function(df){
  mutate(df, y = .data$a+.data$x)
}

df1 = tibble(x = 1:3)
a = 10
mutate_y(df1)

df = tibble(
  g1 = c(1,1,2,2,2),
  g2 = c(1,2,1,2,1),
  a = sample(5),
  b = sample(5)
)

df %>% 
  group_by(g1) %>%
  summarise(a = mean(a))

df %>%
  group_by(g2) %>%
  summarise(a = mean(a))

my_summarise = function(df, group_var){
  group_var = enquo(group_var)
  print(group_var)
  df %>%
    group_by(!! group_var) %>%
    summarise(a = mean(a))
}

# quote(), substitute(), quo(), enquo()

my_summarise(df, g1)

summarise(df, mean = mean(a), sum = sum(a), n=n())
summarise(df, mean = mean(a * b), sum = sum(a * b), n = n())

my_var = quo(a)
summarise(df, mean=mean(!! my_var), sum=sum(!! my_var), n=n())

quo(summarise(df,
              mean=mean(!! my_var),
              sum=sum(!! my_var),
              n=n()
              ))

my_summarise2 = function(df, expr){
  expr = enquo(expr)
  summarise(df, 
          mean = mean(!! expr),
          sum = sum(!! expr),
          n = n()
          )
}

my_summarise2(df, a)
my_summarise2(df, a*b)

mutate(df, mean_a = mean(a), sum_a = sum(a))
mutate(df, mean_b = mean(b), sum_b = sum(b))

my_mutate = function(df, expr){
  expr = enquo(expr)
  mean_name = glue::glue("mean_{quo_name(expr)}")
  sum_name = glue::glue("sum_{quo_name(expr)}")
  
  mutate(df,
         !! mean_name := mean(!! expr),
         !! sum_name := sum(!! expr)
         )
}

my_mutate(df, a)
my_mutate(df, b)

my_summarise3 = function(df, ...){
  group_var = quos(...)
  
  df %>%
    group_by(!!! group_var) %>%
    summarise(a = mean(a))
}

my_summarise3(df, g1, g2)

args = list(na.rm = TRUE, trim = 0.25)
quo(mean(x, !!! args))

args = list(quo(x), na.rm = TRUE, trim = 0.25)
quo(mean(!!! args))

disp ~ cly + drat

toupper(letters[1:5])
quote(toupper(letters[1:5]))

f <- function(x){
  quo(x)
}

x1 <- f(10)
x2 <- f(100)

library(rlang)
get_env(x1)
get_env(x2)

eval_tidy(x1)
eval_tidy(x2)

user_var <- 1000
mtcars %>% summarise(cyl = mean(cyl) * user_var)

typeof(mean)

var <- ~toupper(letters[1:5])
var

get_expr(var)
get_env(var)

quo(toupper(letters[1:5]))

quo(toupper(!! letters[1:5]))

quo(toupper(UQ(letters[1:5])))

var1 <- quo(letters[1:5])
quo(toupper(!! var1))

my_mutate2 <- function(x){
  mtcars %>% 
    select(cyl) %>% 
    slice(1:4) %>% 
    mutate(cyl2 = cyl + (!! x))
}

f <- function(x) quo(x)
expr1 <- f(100)
expr2 <- f(10)

my_mutate2(expr1)
my_mutate2(expr2)

quo(list(!!! letters[1:5]))

x <- list(foo = 1L, bar = quo(baz))
quo(list(!!! x))

args <- list(mean = quo(mean(cyl)), count = quo(n()))
mtcars %>% 
  group_by(am) %>% 
  summarise(!!! args)

mean_nm <- "mean"
count_nm <- "count"

mtcars %>% 
  group_by(am) %>% 
  summarise(
    !! mean_nm := mean(cyl),
    !! count_nm := n()
  )

rm(list=ls())