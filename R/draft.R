#' Get PLL Draft Order
#'
#' @title Get PLL Draft Order
#'
#' @description Retrieves the official draft pick order for a given PLL draft
#'   year and league. Returns one row per draft slot with team ownership and,
#'   once the draft has occurred, the player selected.
#'
#' @param year Integer. Draft year. Default `2025`.
#' @param league Character. League identifier. Default `"PLL"`.
#'
#' @return A tibble with one row per draft slot and 11 columns:
#'   \describe{
#'     \item{id}{Character. Unique identifier for this draft slot record.}
#'     \item{year}{Integer. Draft year.}
#'     \item{round}{Integer. Draft round number.}
#'     \item{round_pick}{Integer. Pick number within the round.}
#'     \item{overall_pick}{Integer. Overall pick number across all rounds.}
#'     \item{team_id}{Character. ID of the team holding the pick.}
#'     \item{league}{Character. League identifier.}
#'     \item{pick_player_name}{Character. Name of the drafted player, or
#'       `NA` if the slot has not yet been filled.}
#'     \item{pick_college}{Character. Player's college, or `NA` if unfilled.}
#'     \item{pick_position}{Character. Player's position, or `NA` if unfilled.}
#'     \item{pick_player_id}{Character. Player ID, or `NA` if unfilled.}
#'   }
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Official 2025 PLL draft order
#' pll_draft_order()
#'
#' # 2026 draft order (may have unfilled pick slots before the draft)
#' pll_draft_order(year = 2026, league = "PLL")
#' }
pll_draft_order <- function(year = 2025, league = "PLL") {
  params <- list(year = year, league = league)

  resp  <- .pll_rest_get("/draft/order", params)
  items <- resp$data$items

  if (is.null(items) || length(items) == 0) {
    return(.empty_draft_order_tibble())
  }

  rows <- lapply(items, .flatten_draft_pick)
  dplyr::bind_rows(rows)
}

.flatten_draft_pick <- function(x) {
  pick <- x$draftPick

  tibble::tibble(
    id           = .safe_val(x, "id"),
    year         = .safe_val(x, "year"),
    round        = .safe_val(x, "round"),
    round_pick   = .safe_val(x, "roundPick"),
    overall_pick = .safe_val(x, "overallPick"),
    team_id      = .safe_val(x, "teamId"),
    league       = .safe_val(x, "league"),

    # draftPick nested object — NA if slot is unfilled
    pick_player_name = if (!is.null(pick)) .safe_val(pick, "playerName") else NA_character_,
    pick_college     = if (!is.null(pick)) .safe_val(pick, "college")    else NA_character_,
    pick_position    = if (!is.null(pick)) .safe_val(pick, "position")   else NA_character_,
    pick_player_id   = if (!is.null(pick)) .safe_val(pick, "playerId")   else NA_character_
  )
}

.empty_draft_order_tibble <- function() {
  tibble::tibble(
    id               = character(),
    year             = integer(),
    round            = integer(),
    round_pick       = integer(),
    overall_pick     = integer(),
    team_id          = character(),
    league           = character(),
    pick_player_name = character(),
    pick_college     = character(),
    pick_position    = character(),
    pick_player_id   = character()
  )
}

#' Get PLL Draft Predictions
#'
#' @title Get PLL Draft Predictions
#'
#' @description Retrieves analyst mock draft rankings and predictions for a
#'   given PLL draft year. These are analyst opinions, not official picks.
#'   For official draft selections use \code{\link{pll_draft_order}}.
#'
#' @param year Integer. Draft year to retrieve predictions for. Default `2026`.
#'
#' @return A tibble with one row per predicted pick and 13 columns:
#'   \describe{
#'     \item{id}{Character. Unique record ID.}
#'     \item{year}{Integer. Draft year.}
#'     \item{analyst_name}{Character. Name of the analyst or source.}
#'     \item{player_name}{Character. Predicted player name.}
#'     \item{image_url}{Character. URL to the player's image.}
#'     \item{position}{Character. Player position.}
#'     \item{college}{Character. Player's college.}
#'     \item{college_logo}{Character. URL to the college's logo.}
#'     \item{overall_rank}{Integer. Analyst's overall draft ranking for the player.}
#'     \item{position_rank}{Integer. Ranking within the player's position group.}
#'     \item{change}{Integer. Change in rank since last update.}
#'     \item{analysis}{Character. Analyst write-up or scouting notes.}
#'     \item{league}{Character. League identifier.}
#'   }
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Mock draft predictions for 2026 (default)
#' pll_draft_predictions()
#'
#' # Predictions for a past draft year
#' pll_draft_predictions(year = 2025)
#' }
pll_draft_predictions <- function(year = 2026) {
  params <- list(year = year)

  resp  <- .pll_rest_get("/draft/predictions", params)
  items <- resp$data$items

  if (is.null(items) || length(items) == 0) {
    return(.empty_draft_predictions_tibble())
  }

  rows <- lapply(items, .flatten_draft_prediction)
  dplyr::bind_rows(rows)
}

.flatten_draft_prediction <- function(x) {
  tibble::tibble(
    id            = .safe_val(x, "id"),
    year          = .safe_val(x, "year"),
    analyst_name  = .safe_val(x, "analystName"),
    player_name   = .safe_val(x, "playerName"),
    image_url     = .safe_val(x, "imageUrl"),
    position      = .safe_val(x, "position"),
    college       = .safe_val(x, "college"),
    college_logo  = .safe_val(x, "collegeLogo"),
    overall_rank  = .safe_val(x, "overallRank"),
    position_rank = .safe_val(x, "positionRank"),
    change        = .safe_val(x, "change"),
    analysis      = .safe_val(x, "analysis"),
    league        = .safe_val(x, "league")
  )
}

.empty_draft_predictions_tibble <- function() {
  tibble::tibble(
    id            = character(),
    year          = integer(),
    analyst_name  = character(),
    player_name   = character(),
    image_url     = character(),
    position      = character(),
    college       = character(),
    college_logo  = character(),
    overall_rank  = integer(),
    position_rank = integer(),
    change        = integer(),
    analysis      = character(),
    league        = character()
  )
}
