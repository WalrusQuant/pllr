# Get PLL Player Season Stats

Retrieves player statistics for a given PLL season year and segment.
Returns one row per player with identity fields, team info, and
approximately 56 individual stat columns, all in snake_case.

## Usage

``` r
pll_player_stats(year = 2025, season_segment = "champseries")
```

## Arguments

- year:

  Integer. Season year. Default `2025`. Season data is only available
  for years in which the season has started or completed.

- season_segment:

  Character. Season segment identifier. Use `"champseries"` (default)
  for Champ Series stats or `"regular"` for regular season stats.

## Value

A tibble with one row per player and approximately 70 snake_case
columns.

Player identity columns: `official_id`, `first_name`, `last_name`,
`slug`, `profile_url`, `jersey_num`, `position`, `position_name`,
`experience`.

Team columns (prefixed with `team_`): `team_official_id`,
`team_full_name`, `team_location`, `team_location_code`,
`team_url_logo`.

Selected stat columns:

- goals:

  Integer. Total goals scored.

- two_point_goals:

  Integer. Two-point goals scored.

- one_point_goals:

  Integer. One-point goals scored.

- assists:

  Integer. Total assists.

- points:

  Integer. Total points (goals + assists).

- shots:

  Integer. Total shots taken.

- shot_pct:

  Numeric. Shot percentage.

- shots_on_goal:

  Integer. Shots on goal.

- saves:

  Integer. Goalie saves.

- save_pct:

  Numeric. Goalie save percentage.

- goals_against:

  Integer. Goals allowed by goalie.

- gaa:

  Numeric. Goals against average.

- faceoffs_won:

  Integer. Faceoffs won.

- faceoffs_lost:

  Integer. Faceoffs lost.

- faceoffs:

  Integer. Total faceoffs taken.

- faceoff_pct:

  Numeric. Faceoff win percentage.

- ground_balls:

  Integer. Ground balls.

- turnovers:

  Integer. Turnovers.

- caused_turnovers:

  Integer. Caused turnovers.

- plus_minus:

  Integer. Plus/minus rating.

- games_played:

  Integer. Games played.

- games_started:

  Integer. Games started.

Additional stat columns: `scoring_points`, `two_point_shot_pct`,
`two_point_shots`, `two_point_shots_on_goal`,
`two_point_shots_on_goal_pct`, `scores_against`, `saa`,
`two_point_goals_against`, `num_penalties`, `pim`, `pim_value`,
`power_play_goals`, `power_play_shots`, `short_handed_goals`,
`short_handed_shots`, `short_handed_goals_against`,
`power_play_goals_against`, `tof`, `goalie_wins`, `goalie_losses`,
`goalie_ties`, `two_pt_gaa`, `fo_record`, `shot_turnovers`, `touches`,
`total_passes`, `unassisted_goals`, `assisted_goals`, `pass_rate`,
`shot_rate`, `goal_rate`, `assist_rate`, `turnover_rate`.

## Examples

``` r
if (FALSE) { # \dontrun{
# Champ Series stats for the default year
pll_player_stats()

# Regular season stats for 2024
pll_player_stats(year = 2024, season_segment = "regular")
} # }
```
