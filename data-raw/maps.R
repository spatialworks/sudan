## Load libraries
library(rgdal)
library(rgeos)
library(raster)
library(sf)
library(magrittr)
library(dplyr)

## Read maps
states <- readOGR(dsn = "data-raw/maps/sudan.gpkg",
                  layer = "state")

states <- subset(states, select = -State)

usethis::use_data(states, overwrite = TRUE, compress = "xz")


localities <- readOGR(dsn = "data-raw/maps/sudan.gpkg",
                      layer = "locality")

localities <- subset(localities, select = c(-Loc_Count, -State))

localities@data <- localities@data %>%
  left_join(y = states@data[ , c("State_En", "stateID")])

usethis::use_data(localities, overwrite = TRUE, compress = "xz")
