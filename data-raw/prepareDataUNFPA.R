## Libraries

library(sudan)
library(pdftools)
library(stringr)

## Read population.pdf
x <- pdf_text(pdf = "data-raw/population/populationEdited.pdf")

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

temp <- str_split(x[127:129], "\n")

p1 <- sd_get_page_locality(page = temp[[1]],
                           startRow = 4,
                           period = 2009:2012)
p2 <- sd_get_page_locality(page = temp[[2]],
                           startRow = 3,
                           period = 2013:2016)

## Extract tables
temp1 <- temp[[3]][3:(3 + 16)] %>%
  stringr::str_remove_all(pattern = ",")
temp1 <- c(temp1[1],
           "          0_4   99999   99999   99999   0_4   99999   99999   99999     ",
           temp1[2:17])
temp2 <- temp[[3]][(22):(39)] %>%
  stringr::str_remove_all(pattern = ",")
## Create joint data.frame
xy <- cbind(stringr::str_split(string = temp1,
                               pattern = " ",
                               simplify = TRUE),
            stringr::str_split(string = temp2,
                               pattern = " ",
                               simplify = TRUE))
## Empty df to concatenate
df <- NULL
## Loop through rows of xy
for(i in 1:nrow(xy)) {
  ## Remove space
  df <- rbind(df, xy[i, ][xy[i, ] != ""])
}
## Remove repeatings columns for age group
df <- data.frame(df[ , c(1:4, 6:8, 10:12, 14:16)], stringsAsFactors = FALSE)
## Change population date to numeric
for(i in 2:ncol(df)) {
  df[ , i] <- as.numeric(df[ , i])
}
## Clean up age groups
df[ , 1] <- stringr::str_replace_all(string = df[ , 1],
                                     pattern = "_",
                                     replacement = "-")
## Rename
colNames <- NULL
##
for(i in 2017:2020) {
  colNames <- c(colNames, paste(c("total", "male", "female"), i, sep = "_"))
}
##
names(df) <- c("ageGrp", colNames)
## replace 0-4 values
df[2, 2:7] <- c(44814, NA, NA, 51800, 15465, 20607)

##
p3 <- df
##
df <- data.frame(state = "Gadarif State",
                 locality = "Albutana",
                 p1, p2[ , 2:ncol(p2)], p3[ , 2:ncol(p3)],
                 stringsAsFactors = FALSE)
##
gadarif0 <- df

##
temp1 <- str_split(x[130:147], "\n")

localities <- c("Alfashaqaa",
                "Algadarif Central",
                "Algadarif Town",
                "Alfaow",
                "Alrrahad",
                "Qalaannahaal")

## Cycle through each remaining locality
df <- NULL
for(i in seq(from = 1, to = length(temp1), by = 3)) {
  xx <- sd_get_page_locality(page = temp1[[i]],
                             startRow = 3,
                             period = 2009:2012)
  xy <- sd_get_page_locality(page = temp1[[i + 1]],
                             startRow = 3,
                             period = 2013:2016)
  xz <- sd_get_page_locality(page = temp1[[i + 2]],
                             startRow = 3,
                             period = 2017:2020)
  df <- rbind(df, data.frame(state = "Gadarif State",
                             locality = "",
                             xx, xy[ , 2:ncol(xy)], xz[ , 2:ncol(xz)],
                             stringsAsFactors = FALSE))
}
##
for(i in seq(from = 1, to = length(localities) * 18, by = 18)) {
  df[i:(i + 17), "locality"] <- localities[((i - 1) / 18) + 1 ]
}
##
gadarif1 <- df

## Extract tables from half page 148
temp1 <- str_split(x[148], "\n")[[1]][5:22] %>%
  stringr::str_remove_all(pattern = ",")
## Create joint data.frame
xy <- stringr::str_split(string = temp1,
                         pattern = " ",
                         simplify = TRUE)
## Empty df to concatenate
df <- NULL
## Loop through rows of xy
for(i in 1:nrow(xy)) {
  ## Remove space
  df <- rbind(df, xy[i, ][xy[i, ] != ""])
}
## Remove repeatings columns for age group
df <- data.frame(df[ , c(1:4, 6:8)], stringsAsFactors = FALSE)
## Change population date to numeric
for(i in 2:ncol(df)) {
  df[ , i] <- as.numeric(df[ , i])
}
## Clean up age groups
df[ , 1] <- stringr::str_replace_all(string = df[ , 1],
                                     pattern = "_",
                                     replacement = "-")
## Rename
colNames <- NULL
##
for(i in 2009:2010) {
  colNames <- c(colNames, paste(c("total", "male", "female"), i, sep = "_"))
}
##
names(df) <- c("ageGrp", colNames)
##
df1 <- df

## Extract tables second half page 148
temp2 <- str_split(x[148], "\n")[[1]][27:44] %>%
  stringr::str_remove_all(pattern = ",")
## Create joint data.frame
xy <- stringr::str_split(string = temp1,
                         pattern = " ",
                         simplify = TRUE)
## Empty df to concatenate
df <- NULL
## Loop through rows of xy
for(i in 1:nrow(xy)) {
  ## Remove space
  df <- rbind(df, xy[i, ][xy[i, ] != ""])
}
## Remove repeatings columns for age group
df <- data.frame(df[ , c(1:4, 6:8)], stringsAsFactors = FALSE)
## Change population date to numeric
for(i in 2:ncol(df)) {
  df[ , i] <- as.numeric(df[ , i])
}
## Clean up age groups
df[ , 1] <- stringr::str_replace_all(string = df[ , 1],
                                     pattern = "_",
                                     replacement = "-")
## Rename
colNames <- NULL
##
for(i in 2011:2012) {
  colNames <- c(colNames, paste(c("total", "male", "female"), i, sep = "_"))
}
##
names(df) <- c("ageGrp", colNames)
##
df2 <- df
##
gadarif2 <- data.frame(df1, df2[ , 2:7])

## Extract tables page 149 to 150
temp3 <- str_split(x[149:150], "\n")[[1]][3:20] %>%
  stringr::str_remove_all(pattern = ",")
temp4 <- str_split(x[149:150], "\n")[[1]][23:40] %>%
  stringr::str_remove_all(pattern = ",")
temp5 <- str_split(x[149:150], "\n")[[2]][3:20] %>%
  stringr::str_remove_all(pattern = ",")
temp6 <- str_split(x[149:150], "\n")[[2]][23:40] %>%
  stringr::str_remove_all(pattern = ",")
## Create joint data.frame
xy <- cbind(stringr::str_split(string = temp3,
                               pattern = " ",
                               simplify = TRUE),
            stringr::str_split(string = temp4,
                               pattern = " ",
                               simplify = TRUE),
            stringr::str_split(string = temp5,
                               pattern = " ",
                               simplify = TRUE),
            stringr::str_split(string = temp6,
                               pattern = " ",
                               simplify = TRUE))
## Empty df to concatenate
df <- NULL
## Loop through rows of xy
for(i in 1:nrow(xy)) {
  ## Remove space
  df <- rbind(df, xy[i, ][xy[i, ] != ""])
}
## Remove repeatings columns for age group
df <- data.frame(df[ , c(2:4, 6:8, 10:12, 14:16, 18:20, 22:24, 26:28, 30:32)],
                 stringsAsFactors = FALSE)
## Change population date to numeric
for(i in 2:ncol(df)) {
  df[ , i] <- as.numeric(df[ , i])
}
## Clean up age groups
df[ , 1] <- stringr::str_replace_all(string = df[ , 1],
                                     pattern = "_",
                                     replacement = "-")
## Rename
colNames <- NULL
##
for(i in 2013:2020) {
  colNames <- c(colNames, paste(c("total", "male", "female"), i, sep = "_"))
}
##
names(df) <- colNames
##
gadarif2 <- data.frame(state = "Gadarif State",
                       locality = "Algallabat West (Kassab)",
                       gadarif2, df)


## Rest of pages
temp7 <- str_split(x[151:156], "\n")

localities <- c("Algooraishaa",
                "Alqalabat East")

## Cycle through each remaining locality
df <- NULL
for(i in seq(from = 1, to = length(temp7), by = 3)) {
  xx <- sd_get_page_locality(page = temp7[[i]],
                             startRow = 3,
                             period = 2009:2012)
  xy <- sd_get_page_locality(page = temp7[[i + 1]],
                             startRow = 3,
                             period = 2013:2016)
  xz <- sd_get_page_locality(page = temp7[[i + 2]],
                             startRow = 3,
                             period = 2017:2020)
  df <- rbind(df, data.frame(state = "Gadarif State",
                             locality = "",
                             xx, xy[ , 2:ncol(xy)], xz[ , 2:ncol(xz)],
                             stringsAsFactors = FALSE))
}
##
for(i in seq(from = 1, to = length(localities) * 18, by = 18)) {
  df[i:(i + 17), "locality"] <- localities[((i - 1) / 18) + 1 ]
}
##
gadarif3 <- df

gadarif <- data.frame(rbind(gadarif0, gadarif1, gadarif2, gadarif3))


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

## First 7 localities
temp <- str_split(x[211:231], "\n")

localities <- c("Algitaina",
                "Omramtaa",
                "Aldowaim",
                "Rabak",
                "Aljabalain",
                "Kosti",
                "Alssalam")

whiteNile <- sd_get_pop_locality(corpus = temp,
                                 state = "White Nile State",
                                 localities = localities)

temp <- str_split(x[232:234], "\n")

p1 <- sd_get_page_locality(page = temp[[1]],
                           startRow = 3,
                           period = 2009:2012)
p2 <- sd_get_page_locality(page = temp[[2]],
                           startRow = 3,
                           period = 2013:2016)

## Extract tables
temp1 <- temp[[3]][2:18] %>%
  stringr::str_remove_all(pattern = ",")
temp1 <- c(temp1[1],
           "          5_9   99999   99999   99999   5_9   99999   99999   99999     ",
           temp1[2:17])
temp2 <- temp[[3]][21:38] %>%
  stringr::str_remove_all(pattern = ",")
## Create joint data.frame
xy <- cbind(stringr::str_split(string = temp1,
                               pattern = " ",
                               simplify = TRUE),
            stringr::str_split(string = temp2,
                               pattern = " ",
                               simplify = TRUE))
## Empty df to concatenate
df <- NULL
## Loop through rows of xy
for(i in 1:nrow(xy)) {
  ## Remove space
  df <- rbind(df, xy[i, ][xy[i, ] != ""])
}
## Remove repeatings columns for age group
df <- data.frame(df[ , c(1:4, 6:8, 10:12, 14:16)], stringsAsFactors = FALSE)
## Change population date to numeric
for(i in 2:ncol(df)) {
  df[ , i] <- as.numeric(df[ , i])
}
## Clean up age groups
df[ , 1] <- stringr::str_replace_all(string = df[ , 1],
                                     pattern = "_",
                                     replacement = "-")
## Rename
colNames <- NULL
##
for(i in 2017:2020) {
  colNames <- c(colNames, paste(c("total", "male", "female"), i, sep = "_"))
}
##
names(df) <- c("ageGrp", colNames)
## replace 0-4 values
df[2, 2:7] <- c(79484, NA, 10331, 112920, 29399, 49867)
p3 <- df

df <- rbind(data.frame(state = "White Nile State",
                       locality = "Tandalti",
                       p1, p2[ , 2:ncol(p2)], p3[ , 2:ncol(p3)],
                       stringsAsFactors = FALSE))

##
whiteNile <- data.frame(rbind(whiteNile, df))

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


###################### North Kordofan - pages 354-399 ##########################

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


###################### South Kordofan - pages 354-398 ##########################

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


###################### North Darfur - pages 403-444 ##########################

temp <- str_split(x[403:444], "\n")

localities <- c("El Malha",
                "Mellit",
                "Sarf Omra",
                "Alseraf",
                "Kebkabiya",
                "Kutum",
                "Alkoma",
                "El Fasher",
                "Taweela",
                "Um Kedada",
                "Kalmando",
                "Alliayied",
                "Altowaisha",
                "Alwaha")

northDarfur <- sd_get_pop_locality(corpus = temp,
                                   state = "North Darfur State",
                                   localities = localities)


###################### East Darfur - pages 449-478 #############################

temp <- str_split(x[449:478], "\n")

localities <- c("Shiairayya",
                "Yaseen",
                "Aldiain",
                "Alfirdose",
                "Asalaya",
                "Abo-Jabra",
                "Bahr-Alarab",
                "Abu-Karinka",
                "Adeela",
                "Kilaikly Abu Salama")

eastDarfur <- sd_get_pop_locality(corpus = temp,
                                  state = "East Darfur State",
                                  localities = localities)


###################### Central Darfur - pages 483-503 ##########################

temp <- str_split(x[483:503], "\n")

localities <- c("Azoom",
                "Zalingay",
                "Nairtaty",
                "Wadi Salih",
                "Bindissi",
                "Mukjar",
                "Omdukhon")

centralDarfur <- sd_get_pop_locality(corpus = temp,
                                     state = "Central Darfur State",
                                     localities = localities)


######################### West Darfur - pages 508-528 ##########################

temp <- str_split(x[508:528], "\n")

localities <- c("Alginaina",
                "Baidah",
                "Forbaranga",
                "Habeela",
                "Kirainik",
                "Koulbos",
                "Sirba")

westDarfur <- sd_get_pop_locality(corpus = temp,
                                  state = "West Darfur State",
                                  localities = localities)


######################### South Darfur - pages 533-595 #########################

temp <- str_split(x[533:595], "\n")

localities <- c("Niyala South",
                "Niyala North",
                "Alwhda",
                "Marshang",
                "Kass",
                "Id Alfursaan",
                "Kubom",
                "Kateela",
                "Alsalam",
                "Bilail",
                "Tolus",
                "Omdafoog",
                "Shattaiya",
                "Damasoa",
                "Booram",
                "Alssontaa",
                "Nitaiga",
                "Rihaid Albirdi",
                "Greeda",
                "Kadnair",
                "Alrradoam")

southDarfur <- sd_get_pop_locality(corpus = temp,
                                   state = "South Darfur State",
                                   localities = localities)


population_UNFPA <- data.frame(rbind(northern, riverNile, redSea, kassala, gadarif,
                                     khartoum, gazira, whiteNile, sinnar, blueNile,
                                     northKordofan, westKordofan, southKordofan,
                                     northDarfur, eastDarfur, centralDarfur,
                                     westDarfur, southDarfur))

usethis::use_data(population_UNFPA, overwrite = TRUE, compress = "xz")
