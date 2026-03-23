#' Get PLL Player Season Stats
#'
#' @title Get PLL Player Season Stats
#'
#' @description Retrieves player statistics for a given PLL season year and
#'   segment. Returns one row per player with identity fields, team info, and
#'   approximately 56 individual stat columns all in snake_case.
#'
#' @param year Integer. Season year. Default `2025`. Season data is only
#'   available for years in which the season has started or completed.
#' @param season_segment Character. Season segment identifier. Use
#'   `"champseries"` (default) for Champ Series stats or `"regular"` for
#'   regular season stats.
#'
#' @return A tibble with one row per player and approximately 70 snake_case
#'   columns. Player identity columns include `official_id`, `first_name`,
#'   `last_name`, `slug`, `profile_url`, `jersey_num`, `position`,
#'   `position_name`, and `experience`. Team columns are prefixed with
#'   `team_` (e.g., `team_official_id`, `team_full_name`, `team_location`,
#'   `team_location_code`, `team_url_logo`). Stat columns include:
#'   \describe{
#'     \item{goals}{Integer. Total goals scored.}
#'     \item{two_point_goals}{Integer. Two-point goals scored.}
#'     \item{one_point_goals}{Integer. One-point goals scored.}
#'     \item{assists}{Integer. Total assists.}
#'     \item{points}{Integer. Total points (goals + assists).}
#'     \item{shots}{Integer. Total shots taken.}
#'     \item{shot_pct}{Numeric. Shot percentage.}
#'     \item{shots_on_goal}{Integer. Shots on goal.}
#'     \item{saves}{Integer. Goalie saves.}
#'     \item{save_pct}{Numeric. Goalie save percentage.}
#'     \item{goals_against}{Integer. Goals allowed by goalie.}
#'     \item{gaa}{Numeric. Goals against average.}
#'     \item{faceoffs_won}{Integer. Faceoffs won.}
#'     \item{faceoffs_lost}{Integer. Faceoffs lost.}
#'     \item{faceoffs}{Integer. Total faceoffs.}
#'     \item{faceoff_pct}{Numeric. Faceoff win percentage.}
#'     \item{ground_balls}{Integer. Ground balls.}
#'     \item{turnovers}{Integer. Turnovers.}
#'     \item{caused_turnovers}{Integer. Caused turnovers.}
#'     \item{plus_minus}{Integer. Plus/minus rating.}
#'     \item{games_played}{Integer. Games played.}
#'     \item{games_started}{Integer. Games started.}
#'   }
#'   Additional columns: `scoring_points`, `two_point_shot_pct`,
#'   `two_point_shots`, `two_point_shots_on_goal`, `two_point_shots_on_goal_pct`,
#'   `scores_against`, `saa`, `two_point_goals_against`, `num_penalties`,
#'   `pim`, `pim_value`, `power_play_goals`, `power_play_shots`,
#'   `short_handed_goals`, `short_handed_shots`, `short_handed_goals_against`,
#'   `power_play_goals_against`, `tof`, `goalie_wins`, `goalie_losses`,
#'   `goalie_ties`, `two_pt_gaa`, `fo_record`, `shot_turnovers`, `touches`,
#'   `total_passes`, `unassisted_goals`, `assisted_goals`, `pass_rate`,
#'   `shot_rate`, `goal_rate`, `assist_rate`, `turnover_rate`.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Champ Series stats for the default year
#' pll_player_stats()
#'
#' # Regular season stats for 2024
#' pll_player_stats(year = 2024, season_segment = "regular")
#' }
pll_player_stats <- function(year = 2025, season_segment = "champseries") {
  params <- list(
    year          = year,
    seasonSegment = season_segment
  )

  resp  <- .pll_rest_get("/players/season-stats", params)
  items <- resp$data$items

  if (is.null(items) || length(items) == 0) {
    return(tibble::tibble())
  }

  rows <- lapply(items, .flatten_player_stat)
  dplyr::bind_rows(rows)
}

.flatten_player_stat <- function(x) {
  team  <- x$team  %||% list()
  stats <- x$stats %||% list()

  tibble::tibble(
    # Player identity
    official_id    = .safe_val(x, "officialId"),
    first_name     = .safe_val(x, "firstName"),
    last_name      = .safe_val(x, "lastName"),
    slug           = .safe_val(x, "slug"),
    profile_url    = .safe_val(x, "profileUrl"),
    jersey_num     = .safe_val(x, "jerseyNum"),
    position       = .safe_val(x, "position"),
    position_name  = .safe_val(x, "positionName"),
    experience     = .safe_val(x, "experience"),

    # Team fields (prefixed)
    team_official_id  = .safe_val(team, "officialId"),
    team_location_code = .safe_val(team, "locationCode"),
    team_location     = .safe_val(team, "location"),
    team_url_logo     = .safe_val(team, "urlLogo"),
    team_full_name    = .safe_val(team, "fullName"),

    # Stats fields
    points                          = .safe_val(stats, "points"),
    scoring_points                  = .safe_val(stats, "scoringPoints"),
    faceoff_pct                     = .safe_val(stats, "faceoffPct"),
    shots                           = .safe_val(stats, "shots"),
    shot_pct                        = .safe_val(stats, "shotPct"),
    shots_on_goal                   = .safe_val(stats, "shotsOnGoal"),
    shots_on_goal_pct               = .safe_val(stats, "shotsOnGoalPct"),
    two_point_shots                 = .safe_val(stats, "twoPointShots"),
    two_point_shot_pct              = .safe_val(stats, "twoPointShotPct"),
    two_point_shots_on_goal         = .safe_val(stats, "twoPointShotsOnGoal"),
    two_point_shots_on_goal_pct     = .safe_val(stats, "twoPointShotsOnGoalPct"),
    save_pct                        = .safe_val(stats, "savePct"),
    one_point_goals                 = .safe_val(stats, "onePointGoals"),
    scores_against                  = .safe_val(stats, "scoresAgainst"),
    saa                             = .safe_val(stats, "saa"),
    games_played                    = .safe_val(stats, "gamesPlayed"),
    goals                           = .safe_val(stats, "goals"),
    two_point_goals                 = .safe_val(stats, "twoPointGoals"),
    assists                         = .safe_val(stats, "assists"),
    ground_balls                    = .safe_val(stats, "groundBalls"),
    turnovers                       = .safe_val(stats, "turnovers"),
    caused_turnovers                = .safe_val(stats, "causedTurnovers"),
    faceoffs_won                    = .safe_val(stats, "faceoffsWon"),
    faceoffs_lost                   = .safe_val(stats, "faceoffsLost"),
    faceoffs                        = .safe_val(stats, "faceoffs"),
    goals_against                   = .safe_val(stats, "goalsAgainst"),
    two_point_goals_against         = .safe_val(stats, "twoPointGoalsAgainst"),
    num_penalties                   = .safe_val(stats, "numPenalties"),
    pim                             = .safe_val(stats, "pim"),
    pim_value                       = .safe_val(stats, "pimValue"),
    saves                           = .safe_val(stats, "saves"),
    power_play_goals                = .safe_val(stats, "powerPlayGoals"),
    power_play_shots                = .safe_val(stats, "powerPlayShots"),
    short_handed_goals              = .safe_val(stats, "shortHandedGoals"),
    short_handed_shots              = .safe_val(stats, "shortHandedShots"),
    short_handed_goals_against      = .safe_val(stats, "shortHandedGoalsAgainst"),
    power_play_goals_against        = .safe_val(stats, "powerPlayGoalsAgainst"),
    tof                             = .safe_val(stats, "tof"),
    goalie_wins                     = .safe_val(stats, "goalieWins"),
    goalie_losses                   = .safe_val(stats, "goalieLosses"),
    goalie_ties                     = .safe_val(stats, "goalieTies"),
    gaa                             = .safe_val(stats, "gaa"),
    two_pt_gaa                      = .safe_val(stats, "twoPtGaa"),
    plus_minus                      = .safe_val(stats, "plusMinus"),
    fo_record                       = .safe_val(stats, "foRecord"),
    shot_turnovers                  = .safe_val(stats, "shotTurnovers"),
    touches                         = .safe_val(stats, "touches"),
    total_passes                    = .safe_val(stats, "totalPasses"),
    unassisted_goals                = .safe_val(stats, "unassistedGoals"),
    assisted_goals                  = .safe_val(stats, "assistedGoals"),
    pass_rate                       = .safe_val(stats, "passRate"),
    shot_rate                       = .safe_val(stats, "shotRate"),
    goal_rate                       = .safe_val(stats, "goalRate"),
    assist_rate                     = .safe_val(stats, "assistRate"),
    turnover_rate                   = .safe_val(stats, "turnoverRate"),
    games_started                   = .safe_val(stats, "gamesStarted")
  )
}
