\name{pll_player_stats}
\alias{pll_player_stats}
\title{Get PLL Player Season Stats}
\description{
Retrieves player statistics for a given PLL season year and segment.
Returns one row per player with identity fields, team info, and
approximately 56 individual stat columns, all in snake_case.
}
\usage{
pll_player_stats(year = 2025, season_segment = "champseries")
}
\arguments{
  \item{year}{Integer. Season year. Default \code{2025}. Season data is only
    available for years in which the season has started or completed.}
  \item{season_segment}{Character. Season segment identifier. Use
    \code{"champseries"} (default) for Champ Series stats or \code{"regular"}
    for regular season stats.}
}
\value{
A tibble with one row per player and approximately 70 snake_case columns.

Player identity columns: \code{official_id}, \code{first_name},
\code{last_name}, \code{slug}, \code{profile_url}, \code{jersey_num},
\code{position}, \code{position_name}, \code{experience}.

Team columns (prefixed with \code{team_}): \code{team_official_id},
\code{team_full_name}, \code{team_location}, \code{team_location_code},
\code{team_url_logo}.

Selected stat columns:
\describe{
  \item{goals}{Integer. Total goals scored.}
  \item{two_point_goals}{Integer. Two-point goals scored.}
  \item{one_point_goals}{Integer. One-point goals scored.}
  \item{assists}{Integer. Total assists.}
  \item{points}{Integer. Total points (goals + assists).}
  \item{shots}{Integer. Total shots taken.}
  \item{shot_pct}{Numeric. Shot percentage.}
  \item{shots_on_goal}{Integer. Shots on goal.}
  \item{saves}{Integer. Goalie saves.}
  \item{save_pct}{Numeric. Goalie save percentage.}
  \item{goals_against}{Integer. Goals allowed by goalie.}
  \item{gaa}{Numeric. Goals against average.}
  \item{faceoffs_won}{Integer. Faceoffs won.}
  \item{faceoffs_lost}{Integer. Faceoffs lost.}
  \item{faceoffs}{Integer. Total faceoffs taken.}
  \item{faceoff_pct}{Numeric. Faceoff win percentage.}
  \item{ground_balls}{Integer. Ground balls.}
  \item{turnovers}{Integer. Turnovers.}
  \item{caused_turnovers}{Integer. Caused turnovers.}
  \item{plus_minus}{Integer. Plus/minus rating.}
  \item{games_played}{Integer. Games played.}
  \item{games_started}{Integer. Games started.}
}

Additional stat columns: \code{scoring_points}, \code{two_point_shot_pct},
\code{two_point_shots}, \code{two_point_shots_on_goal},
\code{two_point_shots_on_goal_pct}, \code{scores_against}, \code{saa},
\code{two_point_goals_against}, \code{num_penalties}, \code{pim},
\code{pim_value}, \code{power_play_goals}, \code{power_play_shots},
\code{short_handed_goals}, \code{short_handed_shots},
\code{short_handed_goals_against}, \code{power_play_goals_against},
\code{tof}, \code{goalie_wins}, \code{goalie_losses}, \code{goalie_ties},
\code{two_pt_gaa}, \code{fo_record}, \code{shot_turnovers}, \code{touches},
\code{total_passes}, \code{unassisted_goals}, \code{assisted_goals},
\code{pass_rate}, \code{shot_rate}, \code{goal_rate}, \code{assist_rate},
\code{turnover_rate}.
}
\examples{
\dontrun{
# Champ Series stats for the default year
pll_player_stats()

# Regular season stats for 2024
pll_player_stats(year = 2024, season_segment = "regular")
}
}
