# Get PLL Free Agents

Retrieves free agent data for a given PLL year via the GraphQL API.
Returns one row per free agent with player identity, team transition
info, and contract status.

## Usage

``` r
pll_free_agents(year = 2026)
```

## Arguments

- year:

  Integer. Year to query. Default `2026`. Free agent data may be sparse
  or unavailable before the offseason period for a given year.

## Value

A tibble with one row per free agent and 14 snake_case columns:

- name:

  Character. Full player name.

- first_name:

  Character. Player first name.

- last_name:

  Character. Player last name.

- slug:

  Character. URL-friendly player slug.

- profile_url:

  Character. URL to the player's profile page.

- age:

  Integer. Player age.

- experience:

  Integer. Years of professional experience.

- position:

  Character. Player position abbreviation.

- status:

  Character. Player roster status.

- official_id:

  Character. Unique official player ID.

- new_contract_status:

  Character. Status of the player's new contract (e.g., `"signed"`,
  `"unsigned"`).

- new_team_id:

  Character. Team ID of the player's new team, or `NA` if unsigned.

- prev_team_id:

  Character. Team ID of the player's previous team.

- thirty_percent_threshold_met:

  Logical. Whether the player has met the 30% salary threshold rule.

## Examples

``` r
if (FALSE) { # \dontrun{
# Free agents for the default year (2026)
pll_free_agents()

# Free agents from a past offseason
pll_free_agents(year = 2025)
} # }
```
