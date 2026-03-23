# Get PLL Draft Predictions

Retrieves analyst mock draft rankings and predictions for a given PLL
draft year. These are analyst opinions, not official picks. For official
draft selections use
[`pll_draft_order`](https://walrusquant.github.io/pllr/reference/pll_draft_order.md).

## Usage

``` r
pll_draft_predictions(year = 2026)
```

## Arguments

- year:

  Integer. Draft year to retrieve predictions for. Default `2026`.

## Value

A tibble with one row per predicted pick and 13 columns:

- id:

  Character. Unique record ID.

- year:

  Integer. Draft year.

- analyst_name:

  Character. Name of the analyst or source.

- player_name:

  Character. Predicted player name.

- image_url:

  Character. URL to the player's image.

- position:

  Character. Player position.

- college:

  Character. Player's college.

- college_logo:

  Character. URL to the college's logo.

- overall_rank:

  Integer. Analyst's overall draft ranking for the player.

- position_rank:

  Integer. Ranking within the player's position group.

- change:

  Integer. Change in rank since the last update.

- analysis:

  Character. Analyst write-up or scouting notes.

- league:

  Character. League identifier.

## Examples

``` r
if (FALSE) { # \dontrun{
# Mock draft predictions for 2026 (default)
pll_draft_predictions()

# Predictions for a past draft year
pll_draft_predictions(year = 2025)
} # }
```
