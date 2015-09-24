# template for period estimation function arguments
#' @title Period Mortality Rate Tabulation and Estimation
#'
#' @description Compute period mortality estimates, or tabulate
#' exposures/deaths, using DHS or IHME methods
#'
#' @param age_death numeric vector giving the age of death in months of each
#'  child. Note that if the child is still alive at the time of interview,
#'  corresponding eleents of \code{age_death} should be given a number greater
#'  than \code{max(windows_upper)}
#'
#' @param birth_int numeric vector giving the time in month between the
#'  child's birth and the interview
#'
#' @param cluster_id vector giving the cluster identifier (can be numeric,
#'  cahracter or factor)
#'
#' @param windows_lower,windows_upper numeric vectors giving the
#'  non-overlapping lower and upper ages in months of each survival window
#'
#' @param period the length of time in months for which mortality rates
#'  should be estimated, either vector or scalar
#'
#' @param method the method used to tabulate exposures and deaths, either by
#'  combining monthly exposures within the window (\code{method = 'monthly'})
#'  or directly counting the individuals exposed over the whole period
#'  (\code{method = 'direct'})
#'
#' @param cohorts the number of cohorts used to tabulate exposures and deaths
#'  for each age bins. If \code{cohorts = 'one'} then only individuals falling
#'  starting and ending the age bin inside the period are counted. If
#'  \code{cohorts = 'three'} then individuals starting but not ending,
#'  or ending but not starting, the age bin inside the period are also counted
#'  but the numbers divided by two.
#'
#' @param inclusion which individuals to include in each cohort:
#'  \code{'enter'}, those \emph{entering} the target ages during the cohort
#'   time period;
#'  \code{'exit'}, those \emph{exiting} the target ages during the cohort time
#'   period;
#'  \code{'both'}, those \emph{both} entering and exiting the target ages
#'   during the cohort time period;
#'  \code{'either'}, those \emph{either} entering or exiting the target ages
#'   during the cohort time period;
#'
#' @param mortality whether to aggregate births/deaths or mortality to return
#'  mortality across each age bin (if \code{mortality = 'bin'}, the default)
#'  or to return \emph{monthly} mortality in that age bin (if
#'  \code{mortality = 'monthly'}). The latter option is only possible if
#'  \code{method = 'monthly'}, an error will be thrown if this isn't the case.
#'
#' @param nperiod the number of consecutive periods to calculate for. I.e.
#'  if \code{period = 12} and \code{nperiod = 3}, numbers will be returned for
#'  periods 0-12, 13-24 and 25-36 months prior to the interview (plus delay).
#'
#' @param delay the length of time in months prior to the interview date
#'  to end the period (I.e. the period runs from \code{period + delay} months
#'  before the interview date to \code{period} days before).
#'  Either vector scalar, or \code{NULL}, in which case the default delay for
#'  \code{cohorts} is used: for \code{cohorts = 'one'} \code{delay = 0}; for
#'  \code{cohorts = 'three'}
#'  \code{delay = max(windows_upper - windows_lower)}.
#'
#' @param verbose whether to regularly report the stage of the analysis
#'
#' @note These functions enable reconstruction of the DHS three-cohort method,
#'  as well as the IHME method, for estimating period mortality rates via
#'  specification of the \code{method},\code{cohorts} and \code{inclusion}
#'  arguments. For the IHME method, the user should specify:
#'  \code{method = 'monthly', cohorts = 'one', inclusion = 'enter'}
#'  and for the DHS method:
#'  \code{method = 'direct', cohorts = 'three', inclusion = 'both'}.
#'  Note that mixing and matching these argument in other ways will likely not
#'  lead to sane mortality rate estiamtes, since indivivduals could be recorded
#'  multiple times.