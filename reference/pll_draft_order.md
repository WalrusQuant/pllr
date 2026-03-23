# Get PLL Draft Order

Retrieves the official draft pick order for a given PLL draft year and
league. Returns one row per draft slot with team ownership and, once the
draft has occurred, the player selected at each slot.

## Usage

``` r
pll_draft_order(year = 2025, league = "PLL")
```

## Arguments

- year:

  Integer. Draft year. Default `2025`.

- league:

  Character. League identifier. Default `"PLL"`.

## Value

A tibble with one row per draft slot and 11 columns:

- id:

  Character. Unique identifier for this draft slot record.

- year:

  Integer. Draft year.

- round:

  Integer. Draft round number.

- round_pick:

  Integer. Pick number within the round.

- overall_pick:

  Integer. Overall pick number across all rounds.

- team_id:

  Character. ID of the team holding the pick.

- league:

  Character. League identifier.

- pick_player_name:

  Character. Name of the drafted player, or `NA` if the slot has not yet
  been filled.

- pick_college:

  Character. Player's college, or `NA` if unfilled.

- pick_position:

  Character. Player's position, or `NA` if unfilled.

- pick_player_id:

  Character. Player ID, or `NA` if unfilled.

## Examples

``` r
if (FALSE) { # \dontrun{
# Official 2025 PLL draft order with picks filled in
pll_draft_order()

# 2026 draft order (pick columns may be NA before the draft)
pll_draft_order(year = 2026, league = "PLL")
} # }
```
