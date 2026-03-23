# Get PLL Events (Games)

Retrieves scheduled and completed game events for a given PLL season
year. Returns one row per game with event metadata, scores, venue info,
and home/away team details.

## Usage

``` r
pll_events(year = 2025, include_cs = TRUE, include_wll = TRUE)
```

## Arguments

- year:

  Integer. Season year. Default `2025`. Season data is only available
  for years in which the season has started or completed.

- include_cs:

  Logical. If `TRUE` (default), include Champ Series events in the
  results.

- include_wll:

  Logical. If `TRUE` (default), include WLL (Women's Lacrosse League)
  events in the results.

## Value

A tibble with one row per game event. Top-level columns include:

- id:

  Character. Internal event ID.

- event_id:

  Character. Public-facing event ID.

- league:

  Character. League identifier (e.g., `"PLL"`).

- season_segment:

  Character. Season segment identifier.

- start_time:

  Character. Event start time (ISO 8601 string).

- week:

  Integer. Week number within the season.

- year:

  Integer. Season year.

- game_number:

  Integer. Game number within the season.

- venue:

  Character. Venue name.

- venue_location:

  Character. Venue city/location.

- broadcaster:

  Character. Broadcast network or streaming platform.

- event_status:

  Character. Event status (e.g., `"final"`, `"scheduled"`).

- game_status:

  Character. Detailed game status string.

- home_score:

  Integer. Home team final score.

- visitor_score:

  Integer. Visiting team final score.

Home team columns are prefixed with `home_` and away team columns with
`away_`. Both sets contain: `official_id`, `year`, `url_logo`,
`full_name`, `location`, `location_code`, `league`, `conference`,
`team_wins`, `team_losses`, `team_ties`, `seed`, `team_color`,
`background_color`.

## Examples

``` r
if (FALSE) { # \dontrun{
# All events for the default year (includes Champ Series and WLL)
pll_events()

# PLL-only regular season events for 2024
pll_events(year = 2024, include_cs = FALSE, include_wll = FALSE)
} # }
```
