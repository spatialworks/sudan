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

## Adjust spelling of states to be compatible with locality results
## State names to change:
##     Gezira         -> Al-Gazeera
##     Gedaref        -> Al-Gadarif
##     North Kordofan -> North Kourdofan
##     Sennar         -> Sinar
##     South Kordofan -> South Kourdofan
##     West Kordofan  -> West Kourdofan
ws2$state <- ifelse(ws2$state == "Gezira", "Al-Gazeera", ws2$state)
ws2$state <- ifelse(ws2$state == "Gedaref", "Al-Gadarif", ws2$state)
ws2$state <- ifelse(ws2$state == "North Kordofan", "North Kourdofan", ws2$state)
ws2$state <- ifelse(ws2$state == "South Kordofan", "South Kourdofan", ws2$state)
ws2$state <- ifelse(ws2$state == "West Kordofan", "West Kourdofan", ws2$state)
ws2$state <- ifelse(ws2$state == "Sennar", "Sinar", ws2$state)

## Adjust spelling of localities to be compatible with locality results
## Al-Gadarif
ws2$locality[ws2$state == "Al-Gadarif"]
ws2[ws2$state == "Al-Gadarif" & ws2$locality == "Gedaref", "locality"] <- "Gedaref Town"
ws2[ws2$state == "Al-Gadarif" & ws2$locality == "MID Gedarif", "locality"] <- "Middle Gedaref"
ws2[ws2$state == "Al-Gadarif" & ws2$locality == "Elbotana", "locality"] <- "Elbutana"
ws2[ws2$state == "Al-Gadarif" & ws2$locality == "Elfashaga", "locality"] <- "El Fashaga"
ws2[ws2$state == "Al-Gadarif" & ws2$locality == "Elrahad", "locality"] <- "El Rahad"
ws2[ws2$state == "Al-Gadarif" & ws2$locality == "Gala alnahal", "locality"] <- "Gala-a El Nahal"
ws2[ws2$state == "Al-Gadarif" & ws2$locality == "Alfao", "locality"] <- "El Fao"
ws2[ws2$state == "Al-Gadarif" & ws2$locality == "East galabat", "locality"] <- "Eastern Galabat"
ws2[ws2$state == "Al-Gadarif" & ws2$locality == "Elmfaza", "locality"] <- "El Mafaza"
ws2[ws2$state == "Al-Gadarif" & ws2$locality == "Basunda", "locality"] <- "Basunda"
ws2[ws2$state == "Al-Gadarif" & ws2$locality == "Algirasha", "locality"] <- "El Qureisha"
ws2[ws2$state == "Al-Gadarif" & ws2$locality == "West galabat", "locality"] <- "Western Galabat"

## Al-Gazeera
ws2$locality[ws2$state == "Al-Gazeera"]
ws2[ws2$state == "Al-Gazeera" & ws2$locality == " Madani", "locality"] <- "Greater Medani"
ws2[ws2$state == "Al-Gazeera" & ws2$locality == "South Gezira", "locality"] <- "Ganub Elgazira"
ws2[ws2$state == "Al-Gazeera" & ws2$locality == "Alhasahisa", "locality"] <- "El Hassahisa"
ws2[ws2$state == "Al-Gazeera" & ws2$locality == "ELKamleen", "locality"] <- "El Kamlin"
ws2[ws2$state == "Al-Gazeera" & ws2$locality == "East Gezira", "locality"] <- "Sharg El Gezira"
ws2[ws2$state == "Al-Gazeera" & ws2$locality == "Umelgura", "locality"] <- "Um Elqura"
ws2[ws2$state == "Al-Gazeera" & ws2$locality == "Almanagil", "locality"] <- "El Manaqil"
ws2[ws2$state == "Al-Gazeera" & ws2$locality == "algurashi", "locality"] <- "El Qurashi"

## Blue Nile
ws2$locality[ws2$state == "Al-Gazeera"]
ws2[ws2$state == "Blue Nile" & ws2$locality == "El Damazin", "locality"] <- "El Damazine"
ws2[ws2$state == "Blue Nile" & ws2$locality == "Tadamoon", "locality"] <- "El Tadamon"
ws2[ws2$state == "Blue Nile" & ws2$locality == "ElRosairs", "locality"] <- "El Roseiris"
ws2[ws2$state == "Blue Nile" & ws2$locality == "Wd almahi", "locality"] <- "Wad El Mahi"
ws2[ws2$state == "Blue Nile" & ws2$locality == "Baw", "locality"] <- "Baw"
ws2[ws2$state == "Blue Nile" & ws2$locality == "Gaisan", "locality"] <- "Geisan"
ws2[ws2$state == "Blue Nile" & ws2$locality == "Elkormok", "locality"] <- "El Kurmuk"

## Central Darfur
ws2$locality[ws2$state == "Central Darfur"]
## Zalingi - ok
## Wadi Salih - ok
ws2[ws2$state == "Central Darfur" & ws2$locality == "Mukjer", "locality"] <- "Mukjar"
ws2[ws2$state == "Central Darfur" & ws2$locality == "Rokero", "locality"] <- "North Jebel Mara"
ws2[ws2$state == "Central Darfur" & ws2$locality == "Golo", "locality"] <- "Central Jebel Mara"
ws2[ws2$state == "Central Darfur" & ws2$locality == "Bondes", "locality"] <- "Bendasi"
ws2[ws2$state == "Central Darfur" & ws2$locality == "Nairtity", "locality"] <- "Nertiti"
ws2[ws2$state == "Central Darfur" & ws2$locality == "Azoom", "locality"] <- "Azum"
ws2[ws2$state == "Central Darfur" & ws2$locality == "Um dokhn", "locality"] <- "Um Dukhun"

## East Darfur
ws2$locality[ws2$state == "East Darfur"]
## Abu Jabra - ok
## Abu Karinka - ok
ws2[ws2$state == "East Darfur" & ws2$locality == "Bahr Alarab", "locality"] <- "Bahr El Arab"
ws2[ws2$state == "East Darfur" & ws2$locality == "Adeila ", "locality"] <- "Adila"
ws2[ws2$state == "East Darfur" & ws2$locality == "Aldein", "locality"] <- "Ed Dain"
## Assalaya - ok
ws2[ws2$state == "East Darfur" & ws2$locality == "El Firduce", "locality"] <- "El Firdous"
ws2[ws2$state == "East Darfur" & ws2$locality == "Shiaria", "locality"] <- "Shia-ria"
ws2[ws2$state == "East Darfur" & ws2$locality == "Yaseen", "locality"] <- "Yassin"

## Kassala
ws2$locality[ws2$state == "Kassala"]
## Kassala Town - ok
ws2[ws2$state == "Kassala" & ws2$locality == "Reifi Kassala", "locality"] <- "Refi Kassla"
ws2[ws2$state == "Kassala" & ws2$locality == "West Kassala", "locality"] <- "Rural Western Kassala"
ws2[ws2$state == "Kassala" & ws2$locality == "Reifi Halfa", "locality"] <- "New Halfa"
ws2[ws2$state == "Kassala" & ws2$locality == "Nahr Atbara ", "locality"] <- "Refi Nahr Atbara"
ws2[ws2$state == "Kassala" & ws2$locality == "Reifi Algirba", "locality"] <- "Rural Khashm Elgirba"
ws2[ws2$state == "Kassala" & ws2$locality == "Reifi Wed Hilaio", "locality"] <- "Rural Wad Elhilaiw"
ws2[ws2$state == "Kassala" & ws2$locality == "Reifi Aroma ", "locality"] <- "Rural Aroma"
ws2[ws2$state == "Kassala" & ws2$locality == "North-DaLta ", "locality"] <- "Refi North Delta"
ws2[ws2$state == "Kassala" & ws2$locality == " Hamshkoreep ", "locality"] <- "Refi Hamashkureib"
ws2[ws2$state == "Kassala" & ws2$locality == "Talkook", "locality"] <- "Rural Telkok"

## Khartoum
ws2$locality[ws2$state == "Khartoum"]
## Khartoum - ok
ws2[ws2$state == "Khartoum" & ws2$locality == "Gebal Awleya", "locality"] <- "Jebel Awlia"
## Um Durman - ok
ws2[ws2$state == "Khartoum" & ws2$locality == "Karary", "locality"] <- "Karrari"
ws2[ws2$state == "Khartoum" & ws2$locality == "Umbada", "locality"] <- "Um Bada"
ws2[ws2$state == "Khartoum" & ws2$locality == "Bahry", "locality"] <- "Bahri"
## Sharg Elneel - ok

## North Darfur
ws2$locality[ws2$state == "North Darfur"]
ws2[ws2$state == "North Darfur" & ws2$locality == "Elfashir", "locality"] <- "El Fasher"
ws2[ws2$state == "North Darfur" & ws2$locality == "Tawela", "locality"] <- "Tawila"
ws2[ws2$state == "North Darfur" & ws2$locality == "Maleet", "locality"] <- "Melit"
ws2[ws2$state == "North Darfur" & ws2$locality == "Um kadada", "locality"] <- "Um Kadada"
ws2[ws2$state == "North Darfur" & ws2$locality == "kabkabeia", "locality"] <- "Kebkabiya"
ws2[ws2$state == "North Darfur" & ws2$locality == "Kotum", "locality"] <- "Kutum"
ws2[ws2$state == "North Darfur" & ws2$locality == "Elmalha", "locality"] <- "El Mahalha"
## Saraf Omra - ok
ws2[ws2$state == "North Darfur" & ws2$locality == "Elsiraif", "locality"] <- "El Serief"
##ws2[ws2$state == "North Darfur" & ws2$locality == "Alwaha", "locality"] <- "???"
ws2[ws2$state == "North Darfur" & ws2$locality == "Dar-Alsalam", "locality"] <- "Dar Elsalam"
ws2[ws2$state == "North Darfur" & ws2$locality == "Klamindo", "locality"] <- "Kelemando"
ws2[ws2$state == "North Darfur" & ws2$locality == "Altiwasha", "locality"] <- "El Tawisha"
ws2[ws2$state == "North Darfur" & ws2$locality == "Am baro", "locality"] <- "Um Baru"
ws2[ws2$state == "North Darfur" & ws2$locality == "Al-liayit", "locality"] <- "El Lait"
ws2[ws2$state == "North Darfur" & ws2$locality == "Elkoma", "locality"] <- "Elkuma"
ws2[ws2$state == "North Darfur" & ws2$locality == "alteena", "locality"] <- "El Tina"
ws2[ws2$state == "North Darfur" & ws2$locality == "Kranoy", "locality"] <- "Kernoi"

## North Kourdofan
ws2$locality[ws2$state == "North Kourdofan"]
ws2[ws2$state == "North Kourdofan" & ws2$locality == "Sheikan ", "locality"] <- "Sheikan"
ws2[ws2$state == "North Kourdofan" & ws2$locality == "Umrowaba", "locality"] <- "Um Rawaba"
ws2[ws2$state == "North Kourdofan" & ws2$locality == "Umdam", "locality"] <- "Um Dam Haj Ahmed"
ws2[ws2$state == "North Kourdofan" & ws2$locality == "Elrahad ", "locality"] <- "El Rahad"
## Bara - ok
ws2[ws2$state == "North Kourdofan" & ws2$locality == "Ewest Bara ", "locality"] <- "Gharb Bara"
ws2[ws2$state == "North Kourdofan" & ws2$locality == "Sodary ", "locality"] <- "Soudari"
ws2[ws2$state == "North Kourdofan" & ws2$locality == "Gabra", "locality"] <- "Gebrat El Sheikh"

## Northern
ws2$locality[ws2$state == "Northern"]
## Dongola - ok
ws2[ws2$state == "Northern" & ws2$locality == "Egoled", "locality"] <- "El Golid"
ws2[ws2$state == "Northern" & ws2$locality == "Marawi", "locality"] <- "Merwoe"
ws2[ws2$state == "Northern" & ws2$locality == "Eldaba", "locality"] <- "El Daba"
ws2[ws2$state == "Northern" & ws2$locality == "Halafa", "locality"] <- "Halfa"
ws2[ws2$state == "Northern" & ws2$locality == "Dalgo", "locality"] <- "Delgo"
ws2[ws2$state == "Northern" & ws2$locality == "Alburgaig", "locality"] <- "El Burgaig"

## Red Sea
ws2$locality[ws2$state == "Red Sea"]
ws2[ws2$state == "Red Sea" & ws2$locality == "Portsudan", "locality"] <- "Port Sudan"
## Swakin - ok
ws2[ws2$state == "Red Sea" & ws2$locality == " GanibOlaib", "locality"] <- "El Ganab Elawlait"
ws2[ws2$state == "Red Sea" & ws2$locality == "Seinkat", "locality"] <- "Sinkat"
## Haya - ok
ws2[ws2$state == "Red Sea" & ws2$locality == "Dordaib", "locality"] <- "Dordieb"
ws2[ws2$state == "Red Sea" & ws2$locality == "Toker", "locality"] <- "Tokar"
ws2[ws2$state == "Red Sea" & ws2$locality == "Ageeg", "locality"] <- "Agig"
ws2[ws2$state == "Red Sea" & ws2$locality == "Gabait ", "locality"] <- "Gabaot Elma-aadin"
ws2[ws2$state == "Red Sea" & ws2$locality == "Halaib", "locality"] <- "Halaeeb"

## River Nile
ws2$locality[ws2$state == "River Nile"]
ws2[ws2$state == "River Nile" & ws2$locality == "Elmatama", "locality"] <- "El Matama"
ws2[ws2$state == "River Nile" & ws2$locality == "Shandi", "locality"] <- "Shendi"
## Abu Hamad - ok
ws2[ws2$state == "River Nile" & ws2$locality == "Berber", "locality"] <- "Barbar"
ws2[ws2$state == "River Nile" & ws2$locality == "Eldamer", "locality"] <- "El Damar"
## Atbara - ok
ws2[ws2$state == "River Nile" & ws2$locality == "Elbohira", "locality"] <- "El Buhaira"

## Sinar
ws2$locality[ws2$state == "Sinar"]
## Sennar - ok
ws2[ws2$state == "Sinar" & ws2$locality == "East Sennar", "locality"] <- "Sharg Sennar"
ws2[ws2$state == "Sinar" & ws2$locality == "Singa", "locality"] <- "Sinja"
ws2[ws2$state == "Sinar" & ws2$locality == "AbuHugar", "locality"] <- "Abu Hujar"
ws2[ws2$state == "Sinar" & ws2$locality == "Adali And Almazmom", "locality"] <- "El Dali"
ws2[ws2$state == "Sinar" & ws2$locality == "Alsooki", "locality"] <- "Es Suki"
ws2[ws2$state == "Sinar" & ws2$locality == "Aldindir", "locality"] <- "Ed Dinder"

## South Darfur
ws2$locality[ws2$state == "South Darfur"]
## Sennar - ok
ws2[ws2$state == "South Darfur" & ws2$locality == "nyala", "locality"] <- "Nyala South"
ws2[ws2$state == "South Darfur" & ws2$locality == "nyala north", "locality"] <- "Nyala North"
ws2[ws2$state == "South Darfur" & ws2$locality == "elsalam", "locality"] <- "Es Salam"
ws2[ws2$state == "South Darfur" & ws2$locality == "Alwahda", "locality"] <- "El Wihda"
ws2[ws2$state == "South Darfur" & ws2$locality == "mershing", "locality"] <- "Mershing"
ws2[ws2$state == "South Darfur" & ws2$locality == "belail", "locality"] <- "Beliel"
ws2[ws2$state == "South Darfur" & ws2$locality == "netiga", "locality"] <- "Nitega"
ws2[ws2$state == "South Darfur" & ws2$locality == "shargalJabal", "locality"] <- "Sharg El Jabal"
ws2[ws2$state == "South Darfur" & ws2$locality == "kass", "locality"] <- "Kas"
ws2[ws2$state == "South Darfur" & ws2$locality == "shatia", "locality"] <- "Shattaya"
ws2[ws2$state == "South Darfur" & ws2$locality == "buraam", "locality"] <- "Buram"
ws2[ws2$state == "South Darfur" & ws2$locality == "garidha", "locality"] <- "Gereida"
ws2[ws2$state == "South Darfur" & ws2$locality == "alsunta", "locality"] <- "El Sunta"
ws2[ws2$state == "South Darfur" & ws2$locality == "alradom", "locality"] <- "El Radoum"
ws2[ws2$state == "South Darfur" & ws2$locality == "tulus", "locality"] <- "Tulus"
ws2[ws2$state == "South Darfur" & ws2$locality == "dimso", "locality"] <- "Damso"
ws2[ws2$state == "South Darfur" & ws2$locality == "idd elfursan", "locality"] <- "Ed Elfursan"
ws2[ws2$state == "South Darfur" & ws2$locality == "kubum", "locality"] <- "Kubum"
ws2[ws2$state == "South Darfur" & ws2$locality == "kateila", "locality"] <- "Kateila"
ws2[ws2$state == "South Darfur" & ws2$locality == "rehaid el burdi", "locality"] <- "Rehaid Elbirdi"
ws2[ws2$state == "South Darfur" & ws2$locality == "umgafoug", "locality"] <- "Um Dafoug"

## South Kourdofan
ws2$locality[ws2$state == "South Kourdofan"]
ws2[ws2$state == "South Kourdofan" & ws2$locality == "kadogli", "locality"] <- "Kadugli"
ws2[ws2$state == "South Kourdofan" & ws2$locality == "AlReif Alshargi", "locality"] <- "Reif Shargi"
ws2[ws2$state == "South Kourdofan" & ws2$locality == "Aldalang", "locality"] <- "Dilling"
ws2[ws2$state == "South Kourdofan" & ws2$locality == "Algooz", "locality"] <- "El Quoz"
ws2[ws2$state == "South Kourdofan" & ws2$locality == "habila", "locality"] <- "Habila"
ws2[ws2$state == "South Kourdofan" & ws2$locality == "Alabasiya", "locality"] <- "Abassiya"
ws2[ws2$state == "South Kourdofan" & ws2$locality == "Alrashad", "locality"] <- "El Rashad"
ws2[ws2$state == "South Kourdofan" & ws2$locality == "AbuGibaiha", "locality"] <- "Abu Jubaiha"
ws2[ws2$state == "South Kourdofan" & ws2$locality == "Altdamon", "locality"] <- "El Tadamon"
## Talodi - ok
ws2[ws2$state == "South Kourdofan" & ws2$locality == "Gadeeir", "locality"] <- "Ghadeer"
ws2[ws2$state == "South Kourdofan" & ws2$locality == "allerei", "locality"] <- "El Leri"
ws2[ws2$state == "South Kourdofan" & ws2$locality == "abokrshola", "locality"] <- "Abu Karshola"
ws2[ws2$state == "South Kourdofan" & ws2$locality == "Dalmi", "locality"] <- "Delami"
##ws2[ws2$state == "South Kourdofan" & ws2$locality == "Umdoren", "locality"] <- "???"
##ws2[ws2$state == "South Kourdofan" & ws2$locality == "Alburam", "locality"] <- "???"
##ws2[ws2$state == "South Kourdofan" & ws2$locality == "Heban", "locality"] <- "???"

## West Darfur
ws2$locality[ws2$state == "West Darfur"]
ws2[ws2$state == "West Darfur" & ws2$locality == "Elgeneina", "locality"] <- "El Geneina"
ws2[ws2$state == "West Darfur" & ws2$locality == "Krainik", "locality"] <- "Kereneik"
ws2[ws2$state == "West Darfur" & ws2$locality == "Habella", "locality"] <- "Habila"
ws2[ws2$state == "West Darfur" & ws2$locality == "Forbaranga", "locality"] <- "Foro Baranga"
## Beida - ok
ws2[ws2$state == "West Darfur" & ws2$locality == "Kolbos", "locality"] <- "Kulbus"
ws2[ws2$state == "West Darfur" & ws2$locality == "Jable mon ", "locality"] <- "Jebel Moon"
ws2[ws2$state == "West Darfur" & ws2$locality == "Sirba ", "locality"] <- "Sirba"

## West Kourdofan
ws2$locality[ws2$state == "West Kourdofan"]
ws2[ws2$state == "West Kourdofan" & ws2$locality == "Abu zabad", "locality"] <- "Abu Zabad"
ws2[ws2$state == "West Kourdofan" & ws2$locality == "Elkhawi", "locality"] <- "ElKhiwai"
ws2[ws2$state == "West Kourdofan" & ws2$locality == "Gebaish", "locality"] <- "Ghubaish"
ws2[ws2$state == "West Kourdofan" & ws2$locality == "Alodia", "locality"] <- "El Idia"
ws2[ws2$state == "West Kourdofan" & ws2$locality == "Elnuhood", "locality"] <- "El Nuhud"
ws2[ws2$state == "West Kourdofan" & ws2$locality == "Wad Banda ", "locality"] <- "Wad Benda"
## Lagawa - ok
ws2[ws2$state == "West Kourdofan" & ws2$locality == "Alsenoot", "locality"] <- "Elsunut"
ws2[ws2$state == "West Kourdofan" & ws2$locality == "Kailak", "locality"] <- "Keilik"
ws2[ws2$state == "West Kourdofan" & ws2$locality == "Alsalam", "locality"] <- "Es Salam"
ws2[ws2$state == "West Kourdofan" & ws2$locality == "Babanoosa", "locality"] <- "Babanusa"
## Abyei - ok
ws2[ws2$state == "West Kourdofan" & ws2$locality == "Eldibab", "locality"] <- "El Dibab"
ws2[ws2$state == "West Kourdofan" & ws2$locality == "Elmairam", "locality"] <- "El Meiram"

## White Nile
ws2$locality[ws2$state == "White Nile"]
## Kosti - ok
## Guli - ok
ws2[ws2$state == "White Nile" & ws2$locality == "Tandalty", "locality"] <- "Tendalti"
ws2[ws2$state == "White Nile" & ws2$locality == "Elsalam", "locality"] <- "Es Salam"
## Rabak - ok
ws2[ws2$state == "White Nile" & ws2$locality == "Elgabalain", "locality"] <- "El Jabalain"
ws2[ws2$state == "White Nile" & ws2$locality == "Eldueim", "locality"] <- "El Diwaim"
ws2[ws2$state == "White Nile" & ws2$locality == "Umrimta", "locality"] <- "Um Rimta"
ws2[ws2$state == "White Nile" & ws2$locality == "Elgetaina", "locality"] <- "El Gitaina"

##
population_CBS <- ws2

## Save in .rda
usethis::use_data(population_CBS, overwrite = TRUE, compress = "xz")

