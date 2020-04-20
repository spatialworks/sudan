## Libraries

library(sudan)
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

################### River Nile - pages 40-57 ###################################

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


################### Red Sea - pages 62-85 ###################################

temp <- str_split(x[62:85], "\n")

localities <- c("Halayib",
                "Alghanib",
                "Port Sudan",
                "Sawaakin",
                "Sinkat",
                "Hayaa",
                "Toakar",
                "Aqeeg")

redSea <- sd_get_pop_locality(corpus = temp,
                              state = "Red Sea State",
                              localities = localities)


################### Kassala - pages 90-122 ###################################

temp <- str_split(x[90:122], "\n")

localities <- c("Eldalta",
                "Hamashkoreeb",
                "Talkook",
                "Aroma Rural",
                "Kassala West",
                "Kassala Town",
                "Kassala Rural",
                "New Halfa",
                "Nahr Atbara",
                "Khashm Elgirba",
                "Wad Alhilaio")

kassala <- sd_get_pop_locality(corpus = temp,
                               state = "Kassala State",
                               localities = localities)


##################### Gadarif - pages 127-156 ###################################

temp <- str_split(x[127:156], "\n")

localities <- c("Albutana",
                "Alfashaqaa",
                "Algadarif Central",
                "Algadarif Town",
                "Alfaow",
                "Alrrahad",
                "Qalaannahaal",
                "Algallabat West (Kassab)",
                "Algooraishaa",
                "Alqalabat East")

gadarif <- sd_get_pop_locality(corpus = temp,
                               state = "Gadarif State",
                               localities = localities)


##################### Khartoum - pages 161-181 #################################

temp <- str_split(x[161:181], "\n")

localities <- c("Omdorman",
                "Karari",
                "Ombadaa",
                "Bahri",
                "Shareq Alneel",
                "Alkhartoum",
                "Jabal Awliya")

khartoum <- sd_get_pop_locality(corpus = temp,
                                state = "Khartoum State",
                                localities = localities)


##################### Gazira - pages 186-206 ###################################

temp <- str_split(x[186:206], "\n")

localities <- c("Algazeera",
                "Alkamleen",
                "Alhisaiheesa",
                "Um alquraa",
                "Wad Madani Alkoobra",
                "South Algazeera",
                "Almanagil")

gazira <- sd_get_pop_locality(corpus = temp,
                              state = "Gazira State",
                              localities = localities)


##################### White Nile - pages 211-234 ###############################

temp <- str_split(x[211:234], "\n")

localities <- c("Algitaina",
                "Omramtaa",
                "Aldowaim",
                "Rabak",
                "Aljabalain",
                "Kosti",
                "Alssalam",
                "Tandalti")

whiteNile <- sd_get_pop_locality(corpus = temp,
                                 state = "White Nile State",
                                 localities = localities)


##################### Sinnar - pages 239-259 ###############################

temp <- str_split(x[239:259], "\n")

localities <- c("Shareq Sinnar",
                "Sinar",
                "Aldindir",
                "Alsooki",
                "Sinja",
                "Abu-Hojar",
                "Aldali")

sinnar <- sd_get_pop_locality(corpus = temp,
                              state = "Sinnar State",
                              localities = localities)


###################### Blue Nile - pages 264-281 ###############################

temp <- str_split(x[264:281], "\n")

localities <- c("Alrosairis",
                "Aldammazeen",
                "Altadamon",
                "Baaw",
                "Geesan",
                "Alkurmook")

blueNile <- sd_get_pop_locality(corpus = temp,
                                state = "Blue Nile State",
                                localities = localities)


###################### North Kordofan - pages 286-309 ##########################

temp <- str_split(x[286:309], "\n")

localities <- c("Om Rwaba",
                "Soadari",
                "Jabrat Elsheekh",
                "Al Rahad",
                "Bara",
                "West Bara",
                "Om Dam Haj Ahmed",
                "Sheekan")

northKordofan <- sd_get_pop_locality(corpus = temp,
                                     state = "North Kordofan State",
                                     localities = localities)


###################### West Kordofan - pages 314-349 ##########################

temp <- str_split(x[314:349], "\n")

localities <- c("Alsalam",
                "Babanosa",
                "Aldibab",
                "Kialak",
                "Lagawa",
                "Alssunoot",
                "Alnehood",
                "Ghibaish",
                "Alodiyah",
                "Al Khiwaiy",
                "Abuzabad",
                "Wadbandaa")

westKordofan <- sd_get_pop_locality(corpus = temp,
                                    state = "West Kordofan State",
                                    localities = localities)


###################### South Kordofan - pages 354-399 ##########################

temp <- str_split(x[354:398], "\n")

localities <- c("Al abassia",
                "Al rashaad",
                "Abukarshola",
                "Abujibaiha",
                "Altadamon",
                "Al Dalang",
                "Algooz",
                "Habeela",
                "Dallami",
                "Om Doorin",
                "Kadoogli",
                "Taloadi",
                "Gadeer",
                "Al Leeri",
                "Al Reefalshargi")

southKordofan <- sd_get_pop_locality(corpus = temp,
                                     state = "South Kordofan State",
                                     localities = localities)
