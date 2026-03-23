#' Get PLL Standings
#'
#' @title Get PLL Standings
#'
#' @description Retrieves team standings for a given PLL season year and
#'   segment. Returns one row per team with win/loss records, score totals,
#'   and conference breakdown.
#'
#' @param year Integer. Season year. Default `2025`. Season data is only
#'   available for years in which the season has started or completed.
#' @param champ_series Logical. If `TRUE` (default), returns Champ Series
#'   standings. If `FALSE`, returns regular season standings.
#'
#' @return A tibble with one row per team and 19 snake_case columns:
#'   \describe{
#'     \item{team_id}{Character. Unique team identifier.}
#'     \item{full_name}{Character. Full team name (e.g., "Atlas LC").}
#'     \item{location}{Character. Team city/location name.}
#'     \item{location_code}{Character. Short location code.}
#'     \item{url_logo}{Character. URL to the team logo image.}
#'     \item{seed}{Integer. Team seed in the standings.}
#'     \item{wins}{Integer. Total wins.}
#'     \item{losses}{Integer. Total losses.}
#'     \item{ties}{Integer. Total ties.}
#'     \item{scores}{Integer. Total goals scored.}
#'     \item{scores_against}{Integer. Total goals allowed.}
#'     \item{score_diff}{Integer. Goal differential (scores - scores_against).}
#'     \item{conference_wins}{Integer. Conference wins.}
#'     \item{conference_losses}{Integer. Conference losses.}
#'     \item{conference_ties}{Integer. Conference ties.}
#'     \item{conference_scores}{Integer. Goals scored in conference games.}
#'     \item{conference_scores_against}{Integer. Goals allowed in conference games.}
#'     \item{conference}{Character. Conference name.}
#'     \item{conference_seed}{Integer. Seed within the team's conference.}
#'   }
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Champ Series standings for the current default year
#' pll_standings()
#'
#' # Regular season standings for 2024
#' pll_standings(year = 2024, champ_series = FALSE)
#' }
pll_standings <- function(year = 2025, champ_series = TRUE) {
  params <- list(
    year        = year,
    champSeries = tolower(as.character(champ_series))
  )

  resp  <- .pll_rest_get("/standings", params)
  items <- resp$data$items

  if (is.null(items) || length(items) == 0) {
    return(.empty_standings_tibble())
  }

  rows <- lapply(items, .flatten_standing)
  dplyr::bind_rows(rows)
}

.flatten_standing <- function(x) {
  tibble::tibble(
    team_id                    = .safe_val(x, "teamId"),
    full_name                  = .safe_val(x, "fullName"),
    location                   = .safe_val(x, "location"),
    location_code              = .safe_val(x, "locationCode"),
    url_logo                   = .safe_val(x, "urlLogo"),
    seed                       = .safe_val(x, "seed"),
    wins                       = .safe_val(x, "wins"),
    losses                     = .safe_val(x, "losses"),
    ties                       = .safe_val(x, "ties"),
    scores                     = .safe_val(x, "scores"),
    scores_against             = .safe_val(x, "scoresAgainst"),
    score_diff                 = .safe_val(x, "scoreDiff"),
    conference_wins            = .safe_val(x, "conferenceWins"),
    conference_losses          = .safe_val(x, "conferenceLosses"),
    conference_ties            = .safe_val(x, "conferenceTies"),
    conference_scores          = .safe_val(x, "conferenceScores"),
    conference_scores_against  = .safe_val(x, "conferenceScoresAgainst"),
    conference                 = .safe_val(x, "conference"),
    conference_seed            = .safe_val(x, "conferenceSeed")
  )
}

.empty_standings_tibble <- function() {
  tibble::tibble(
    team_id                   = character(),
    full_name                 = character(),
    location                  = character(),
    location_code             = character(),
    url_logo                  = character(),
    seed                      = integer(),
    wins                      = integer(),
    losses                    = integer(),
    ties                      = integer(),
    scores                    = integer(),
    scores_against            = integer(),
    score_diff                = integer(),
    conference_wins           = integer(),
    conference_losses         = integer(),
    conference_ties           = integer(),
    conference_scores         = integer(),
    conference_scores_against = integer(),
    conference                = character(),
    conference_seed           = integer()
  )
}
