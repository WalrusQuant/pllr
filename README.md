# pllr

An R package that wraps the Premier Lacrosse League (PLL) stats API and returns results as tibbles with snake_case column names.

## Installation

From GitHub:

```r
# install.packages("devtools")
devtools::install_github("adamwickwire/pllr")
```

From a local clone:

```r
devtools::install("path/to/pllr")
```

## Quick Start

```r
library(pllr)

# Team standings (Champ Series, 2025)
standings <- pll_standings(year = 2025, champ_series = TRUE)
# # A tibble: 14 × 19
# # team_id  full_name         location  wins losses ties scores scores_against ...

# Player season stats
stats <- pll_player_stats(year = 2025, season_segment = "champseries")
# # A tibble: ~200 × 70
# # official_id  first_name  last_name  position  goals  assists  points ...

# Game schedule and results
events <- pll_events(year = 2025, include_cs = TRUE, include_wll = TRUE)
# # A tibble: ~80 × 64
# # id  event_id  start_time  venue  broadcaster  home_full_name  away_full_name  home_score  away_score ...

# Draft pick order
draft <- pll_draft_order(year = 2025, league = "PLL")
# # A tibble: ~60 × 11
# # id  year  round  round_pick  overall_pick  team_id  pick_player_name ...

# Mock draft rankings / predictions
predictions <- pll_draft_predictions(year = 2026)
# # A tibble: ~30 × 13
# # id  year  analyst_name  player_name  position  college  overall_rank  analysis ...

# Free agents
free_agents <- pll_free_agents(year = 2026)
# # A tibble: ~50 × 14
# # name  position  age  prev_team_id  new_team_id  new_contract_status ...
```

## Function Reference

### `pll_standings(year = 2025, champ_series = TRUE)`

Returns team standings for the specified season.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `year` | integer | `2025` | Season year |
| `champ_series` | logical | `TRUE` | If `TRUE`, returns Champ Series standings; `FALSE` returns regular season |

**Returns:** A tibble with one row per team. Key columns: `team_id`, `full_name`, `location`, `location_code`, `url_logo`, `seed`, `wins`, `losses`, `ties`, `scores`, `scores_against`, `score_diff`, `conference_wins`, `conference_losses`, `conference_ties`, `conference_scores`, `conference_scores_against`, `conference`, `conference_seed`.

---

### `pll_player_stats(year = 2025, season_segment = "champseries")`

Returns player statistics for the specified season and segment.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `year` | integer | `2025` | Season year |
| `season_segment` | character | `"champseries"` | Season segment — `"champseries"` or `"regular"` |

**Returns:** A tibble with one row per player and approximately 70 snake_case columns. Player identity columns: `official_id`, `first_name`, `last_name`, `slug`, `jersey_num`, `position`, `position_name`, `experience`. Team columns are prefixed with `team_` (e.g., `team_full_name`, `team_location_code`). Stat columns include `goals`, `assists`, `points`, `shots`, `shot_pct`, `saves`, `save_pct`, `faceoffs_won`, `faceoff_pct`, `ground_balls`, `turnovers`, `caused_turnovers`, `gaa`, `plus_minus`, and many more.

---

### `pll_events(year = 2025, include_cs = TRUE, include_wll = TRUE)`

Returns the game schedule and results for the specified season.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `year` | integer | `2025` | Season year |
| `include_cs` | logical | `TRUE` | Include Champ Series events |
| `include_wll` | logical | `TRUE` | Include WLL events |

**Returns:** A tibble with one row per game event. Top-level columns include `id`, `event_id`, `league`, `season_segment`, `start_time`, `week`, `year`, `game_number`, `venue`, `venue_location`, `broadcaster`, `event_status`, `game_status`, `home_score`, `visitor_score`. Home team columns are prefixed with `home_` and away team columns with `away_` (e.g., `home_full_name`, `away_full_name`, `home_url_logo`).

---

### `pll_draft_order(year = 2025, league = "PLL")`

Returns the draft pick order for the specified year and league.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `year` | integer | `2025` | Draft year |
| `league` | character | `"PLL"` | League identifier |

**Returns:** A tibble with one row per draft slot. Columns: `id`, `year`, `round`, `round_pick`, `overall_pick`, `team_id`, `league`. Pick-specific columns are prefixed with `pick_`: `pick_player_name`, `pick_college`, `pick_position`, `pick_player_id`. Pick columns are `NA` for unfilled slots.

---

### `pll_draft_predictions(year = 2026)`

Returns analyst mock draft rankings for the specified year.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `year` | integer | `2026` | Draft year to retrieve predictions for |

**Returns:** A tibble with one row per predicted pick. Columns: `id`, `year`, `analyst_name`, `player_name`, `image_url`, `position`, `college`, `college_logo`, `overall_rank`, `position_rank`, `change`, `analysis`, `league`.

---

### `pll_free_agents(year = 2026)`

Returns free agent data for the specified year.

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `year` | integer | `2026` | Year to query |

**Returns:** A tibble with one row per free agent. Columns: `name`, `first_name`, `last_name`, `slug`, `profile_url`, `age`, `experience`, `position`, `status`, `official_id`, `new_contract_status`, `new_team_id`, `prev_team_id`, `thirty_percent_threshold_met`.

---

## Notes

- **Data availability:** Season data (standings, player stats, events) is only available during or after the season has been played. Querying a future or in-progress season may return partial or empty results.
- **Column naming:** All returned tibble columns use `snake_case`. The underlying API uses camelCase; the package converts all names automatically.
- **Draft predictions:** `pll_draft_predictions()` returns analyst mock draft rankings, not official picks. Use `pll_draft_order()` for official selections.
- **Free agents:** `pll_free_agents()` uses the GraphQL API endpoint; all other functions use the REST API.

## License

MIT
