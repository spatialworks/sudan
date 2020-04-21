## Libraries
library(openxlsx)

##
wsNames <- getSheetNames(file = "data-raw/population/Sudan CBS locality level population 2018.xlsx")

## Read sheet 1
ws1 <- read.xlsx(xlsxFile = "data-raw/population/Sudan CBS locality level population 2018.xlsx",
                 sheet = "KHA")

## Read sheet 2
ws2 <- read.xlsx(xlsxFile = "data-raw/population/Sudan CBS locality level population 2018.xlsx",
                 sheet = "with Locs")

## Read sheet 3
ws3 <- read.xlsx(xlsxFile = "data-raw/population/Sudan CBS locality level population 2018.xlsx",
                 sheet = "Sudan Denominators(access) 2019")

##
names(ws2) <- c("state", "locality", "pop")

##
population_CBS <- ws2

## Save in .rda
usethis::use_data(population_CBS, overwrite = TRUE, compress = "xz")

