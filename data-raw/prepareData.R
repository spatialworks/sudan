## Libraries

library(pdftools)
library(stringr)

## Read population.pdf
x <- pdf_text(pdf = "data-raw/population/population.pdf")

####################### States population - page 10 ############################

## Re-organise page 10 of states population
temp <- str_split(x[10], "\n")

## Handle data from 2009-2014
temp1 <- temp[[1]][c(3:21)] %>%
  str_replace_all(pattern = ",", replacement = "") %>%
  str_replace_all(pattern = "                ", replacement = ",") %>%
  str_replace_all(pattern = "               ", replacement = ",") %>%
  str_replace_all(pattern = "              ", replacement = ",") %>%
  str_replace_all(pattern = "             ", replacement = ",") %>%
  str_replace_all(pattern = "            ", replacement = ",") %>%
  str_replace_all(pattern = "           ", replacement = ",") %>%
  str_replace_all(pattern = "          ", replacement = ",") %>%
  str_replace_all(pattern = "         ", replacement = ",") %>%
  str_replace_all(pattern = "        ", replacement = ",") %>%
  str_replace_all(pattern = "       ", replacement = ",") %>%
  str_replace_all(pattern = "      ", replacement = ",") %>%
  str_replace_all(pattern = "     ", replacement = ",") %>%
  str_replace_all(pattern = "    ", replacement = ",") %>%
  str_replace_all(pattern = "   ", replacement = ",") %>%
  str_replace_all(pattern = "  ", replacement = ",") %>%
  str_split(pattern = ",", simplify = TRUE)

## Handle data from 2015-2020
temp2 <- temp[[1]][c(24:42)] %>%
  str_replace_all(pattern = ",", replacement = "") %>%
  str_replace_all(pattern = "                ", replacement = ",") %>%
  str_replace_all(pattern = "               ", replacement = ",") %>%
  str_replace_all(pattern = "              ", replacement = ",") %>%
  str_replace_all(pattern = "             ", replacement = ",") %>%
  str_replace_all(pattern = "            ", replacement = ",") %>%
  str_replace_all(pattern = "           ", replacement = ",") %>%
  str_replace_all(pattern = "          ", replacement = ",") %>%
  str_replace_all(pattern = "         ", replacement = ",") %>%
  str_replace_all(pattern = "        ", replacement = ",") %>%
  str_replace_all(pattern = "       ", replacement = ",") %>%
  str_replace_all(pattern = "      ", replacement = ",") %>%
  str_replace_all(pattern = "     ", replacement = ",") %>%
  str_replace_all(pattern = "    ", replacement = ",") %>%
  str_replace_all(pattern = "   ", replacement = ",") %>%
  str_replace_all(pattern = "  ", replacement = ",") %>%
  str_split(pattern = ",", simplify = TRUE)

df <- data.frame(temp1, temp2[ , 2:7])
names(df) <- c("location", 2009:2020)

df$location <- df$location %>%
  str_replace_all(pattern = "N\\.", replacement = "North") %>%
  str_replace_all(pattern = "S\\.", replacement = "South") %>%
  str_replace_all(pattern = "E\\.", replacement = "East") %>%
  str_replace_all(pattern = "W\\.", replacement = "West") %>%
  str_replace_all(pattern = "C\\.", replacement = "Central") %>%
  str_replace(pattern = " ", replacement = "")

################### Northern State Localities - pages 15-35 ####################

temp <- str_split(x[15:35], "\n")

localities <- c("Halfa",
                "Dalgo",
                "Alborgaig",
                "Dongla",
                "Algolid",
                "Aldabba",
                "Marawi")

northern <- sd_get_pop_locality(corpus = temp,
                                state = "Northern State",
                                localities = localities)

################### River Nile - pages 40-57 ####################

temp <- str_split(x[40:57], "\n")

localities <- c("Elmatamma",
                "Berbar",
                "Atbara",
                "Eldamar",
                "Shendi",
                "Ubu Hamad")

riverNile <- sd_get_pop_locality(corpus = temp,
                                 state = "River Nile State",
                                 localities = localities)


################### River Nile - pages 40-57 ####################

temp <- str_split(x[40:57], "\n")

localities <- c("Elmatamma",
                "Berbar",
                "Atbara",
                "Eldamar",
                "Shendi",
                "Ubu Hamad")

riverNile <- sd_get_pop_locality(corpus = temp,
                                 state = "River Nile State",
                                 localities = localities)





