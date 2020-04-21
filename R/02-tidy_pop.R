################################################################################
#
#'
#' Tidy up population projections data from UNFPA
#'
#' A convenience wrapper to tidyr::pivot_longer to switch population projections
#' from UNFPA to long format.
#'
#' @return A tibble containing 6 columns and 110808 rows that is a longer
#'   format version of the UNFPA population dataset
#'
#' @examples
#' sd_tidy_pop()
#'
#' @export
#'
#'
#
################################################################################

sd_tidy_pop <- function() {
  ## Pivot data to longer format
  population_UNFPA_long <- tidyr::pivot_longer(data = sudan::population_UNFPA,
                                               cols = "total_2009":"female_2020",
                                               names_to = c("sex", "year"),
                                               names_sep = "_",
                                               values_to = "population")
  ## Tidy up new sex column
  population_UNFPA_long$sex <- stringr::str_to_sentence(population_UNFPA_long$sex)
  ## Return population in long format
  return(population_UNFPA_long)
}
