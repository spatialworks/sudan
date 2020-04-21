################################################################################
#
#'
#' Exract per page locality population tables from a PDF copy of the UNFPA's
#' Sudan population projections from 2009-2020
#'
#' @param page An object representing one page text from the UNFPA's Sudan
#'   population projections for a locality. This is extracted using the
#'   \code{pdf_text()} function from the \code{pdftools} package
#' @param startRow Numeric value indicating the starting point of actual data
#'   from the tables
#' @param period A range of years in 4-year groups starting from 2009 up to
#'   2020
#' @param labs Labels for the population data columns for each reported year;
#'   Default to c("total", "male", "female")
#' @param sep Separator to use when labeling columns using \code{labs} and
#'   reporting year
#'
#' @return A data.frame of population data from the given page and specified
#'   years
#'
#' @export
#'
#
################################################################################

sd_get_page_locality <- function(page,
                                 startRow,
                                 period,
                                 labs = c("total", "male", "female"),
                                 sep = "_") {
  ## Extract tables
  temp1 <- page[startRow:(startRow + 17)] %>%
    stringr::str_remove_all(pattern = ",")
  temp2 <- page[(startRow + 20):(startRow + 37)] %>%
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
  for(i in period) {
    colNames <- c(colNames, paste(labs, i, sep = sep))
  }
  ##
  names(df) <- c("ageGrp", colNames)
  ## Return df
  return(df)
}


################################################################################
#
#'
#' Exract locality population data from a set of pages for a specific state
#' from UNFPA's Sudan population projections for 2009-2020
#'
#' @param corpus An object representing text data extracted from the UNPFA
#'   Sudan population projections for a specific state. This is extracted using
#'   the \code{pdf_text()} function from the \code{pdftools} package
#' @param state Name of state to which current data is for
#' @param localities A vector of localities name for the given state
#'
#' @return A data.frame of population data for localities in a given state
#'
#' @export
#'
#
################################################################################

sd_get_pop_locality <- function(corpus, state, localities) {

  p1 <- sd_get_page_locality(page = corpus[[1]],
                             startRow = 4,
                             period = 2009:2012)
  p2 <- sd_get_page_locality(page = corpus[[2]],
                             startRow = 3,
                             period = 2013:2016)
  p3 <- sd_get_page_locality(page = corpus[[3]],
                             startRow = 3,
                             period = 2017:2020)

  df <- data.frame(state = state,
                   locality = "",
                   p1, p2[ , 2:ncol(p2)], p3[ , 2:ncol(p3)],
                   stringsAsFactors = FALSE)
  ## Cycle through each remaining locality
  for(i in seq(from = 4, to = length(corpus), by = 3)) {
    xx <- sd_get_page_locality(page = corpus[[i]],
                               startRow = 3,
                               period = 2009:2012)
    xy <- sd_get_page_locality(page = corpus[[i + 1]],
                               startRow = 3,
                               period = 2013:2016)
    xz <- sd_get_page_locality(page = corpus[[i + 2]],
                               startRow = 3,
                               period = 2017:2020)
    df <- rbind(df, data.frame(state = state,
                               locality = "",
                               xx, xy[ , 2:ncol(xy)], xz[ , 2:ncol(xz)],
                               stringsAsFactors = FALSE))
  }
  ##
  for(i in seq(from = 1, to = length(localities) * 18, by = 18)) {
    df[i:(i + 17), "locality"] <- localities[((i - 1) / 18) + 1 ]
  }
  ##
  return(df)
}


