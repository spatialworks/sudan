################################################################################
#
#' Sudan population projections from 2009 to 2020 by 5-year age groups by state
#' and locality in wide format
#'
#' @format A data.frame of 39 columns and 3078 rows:
#' \describe{
#'   \item{\code{state}}{State name}
#'   \item{\code{locality}}{Locality name}
#'   \item{\code{ageGrp}}{5-year age groups}
#'   \item{\code{total_2009}}{Total population for 2009}
#'   \item{\code{male_2009}}{Male population for 2009}
#'   \item{\code{female_2009}}{Female population for 2009}
#'   \item{\code{total_2010}}{Total population for 2010}
#'   \item{\code{male_2010}}{Male population for 2010}
#'   \item{\code{female_2010}}{Female population for 2010}
#'   \item{\code{total_2011}}{Total population for 2011}
#'   \item{\code{male_2011}}{Male population for 2011}
#'   \item{\code{female_2011}}{Female population for 2011}
#'   \item{\code{total_2012}}{Total population for 2012}
#'   \item{\code{male_2012}}{Male population for 2012}
#'   \item{\code{female_2012}}{Female population for 2012}
#'   \item{\code{total_2013}}{Total population for 2013}
#'   \item{\code{male_2013}}{Male population for 2013}
#'   \item{\code{female_2013}}{Female population for 2013}
#'   \item{\code{total_2014}}{Total population for 2014}
#'   \item{\code{male_2014}}{Male population for 2014}
#'   \item{\code{female_2014}}{Female population for 2014}
#'   \item{\code{total_2015}}{Total population for 2015}
#'   \item{\code{male_2015}}{Male population for 2015}
#'   \item{\code{female_2015}}{Female population for 2015}
#'   \item{\code{total_2016}}{Total population for 2016}
#'   \item{\code{male_2016}}{Male population for 2016}
#'   \item{\code{female_2016}}{Female population for 2016}
#'   \item{\code{total_2017}}{Total population for 2017}
#'   \item{\code{male_2017}}{Male population for 2017}
#'   \item{\code{female_2017}}{Female population for 2017}
#'   \item{\code{total_2018}}{Total population for 2018}
#'   \item{\code{male_2018}}{Male population for 2018}
#'   \item{\code{female_2018}}{Female population for 2018}
#'   \item{\code{total_2019}}{Total population for 2019}
#'   \item{\code{male_2019}}{Male population for 2019}
#'   \item{\code{female_2019}}{Female population for 2019}
#'   \item{\code{total_2020}}{Total population for 2020}
#'   \item{\code{male_2020}}{Male population for 2020}
#'   \item{\code{female_2020}}{Female population for 2020}
#' }
#'
#' @examples
#' population_UNFPA
#'
#' @source UNFPA Sudan Population Projections 2009-2020
#'
#
################################################################################
"population_UNFPA"


################################################################################
#
#' Sudan population projection 2018 by locality from Sudan Central Bureau of
#' Statistics
#'
#' @format A data.frame of 3 columns and 189 rows:
#' \describe{
#'   \item{\code{state}}{State name}
#'   \item{\code{locality}}{Locality name}
#'   \item{\code{pop}}{Population}
#' }
#'
#' @examples
#' population_CBS
#'
#' @source Sudan Central Bureau of Statistics
#'
#
################################################################################
"population_CBS"


################################################################################
#
#' Sudan population projection 2018 by locality from Sudan Central Bureau of
#' Statistics and UNICEF and Ministry of Health including 3 IDP camps for use
#' in S3M analysis
#'
#' @format A data.frame of 3 columns and 192 rows:
#' \describe{
#'   \item{\code{state}}{State name}
#'   \item{\code{locality}}{Locality name}
#'   \item{\code{pop}}{Population}
#' }
#'
#' @examples
#' population_S3M
#'
#' @source Sudan Central Bureau of Statistics, UNICEF and Ministry of Health
#'
#
################################################################################
"population_S3M"


################################################################################
#
#'
#' Map of states of Sudan
#'
#' @format A SpatialPolygonsDataFrame with 18 features and 10 fields
#'
#' | **Variables** | **Description** |
#' | *OBJECTID_1* | Object identifier |
#' | *POP_2008* | Population in 2008 |
#' | *POP_2018* | Population in 2018 |
#' | *POP2019* | Population in 2019 |
#' | *State_En* | Name of state (English) |
#' | *Shape_Le_2* | Shape size |
#' | *Area_1* | Area size |
#' | *Code_1* | Area code |
#' | *stateID* | State identifier |
#'
#' @source Sudan Central Bureau of Statistics
#'
#
################################################################################
"states"


################################################################################
#
#'
#' Map of localities of Sudan
#'
#' @format A SpatialPolygonsDataFrame with 188 features and 11 fields.
#'
#' | **Variables** | **Description** |
#' | *OBJECTID_1* | Object identifier 1 |
#' | *OBJECTID* | Object identifier |
#' | *Toto_Pop* | Total population |
#' | *Name_Engli* | Name of state (English) |
#' | *Locality_G* | Locality code |
#' | *Shape_Le_2* | Shape size |
#' | *Shape_Area* | Shape area |
#' | *stateID* | State identifier |
#' | *localityID* | Locality identifier |
#'
#' @source Sudan Central Bureau of Statistics
#'
#
################################################################################
"localities"
