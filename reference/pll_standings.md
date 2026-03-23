# Get PLL Standings

Retrieves team standings for a given PLL season year and segment.
Returns one row per team with win/loss records, score totals, and
conference breakdown.

## Usage

``` r
pll_standings(year = 2025, champ_series = TRUE)
```

## Arguments

- year:

  Integer. Season year. Default `2025`. Season data is only available
  for years in which the season has started or completed.

- champ_series:

  Logical. If `TRUE` (default), returns Champ Series standings. If
  `FALSE`, returns regular season standings.

## Value

A tibble with one row per team and 19 snake_case columns:

- team_id:

  Character. Unique team identifier.

- full_name:

  Character. Full team name (e.g., `"Atlas LC"`).

- location:

  Character. Team city/location name.

- location_code:

  Character. Short location code.

- url_logo:

  Character. URL to the team logo image.

- seed:

  Integer. Team seed in the standings.

- wins:

  Integer. Total wins.

- losses:

  Integer. Total losses.

- ties:

  Integer. Total ties.

- scores:

  Integer. Total goals scored.

- scores_against:

  Integer. Total goals allowed.

- score_diff:

  Integer. Goal differential (scores - scores_against).

- conference_wins:

  Integer. Conference wins.

- conference_losses:

  Integer. Conference losses.

- conference_ties:

  Integer. Conference ties.

- conference_scores:

  Integer. Goals scored in conference games.

- conference_scores_against:

  Integer. Goals allowed in conference games.

- conference:

  Character. Conference name.

- conference_seed:

  Integer. Seed within the team's conference.

## Examples

``` r
if (FALSE) { # \dontrun{
# Champ Series standings for the current default year
pll_standings()

# Regular season standings for 2024
pll_standings(year = 2024, champ_series = FALSE)
} # }
```
