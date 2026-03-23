\name{pll_free_agents}
\alias{pll_free_agents}
\title{Get PLL Free Agents}
\description{
Retrieves free agent data for a given PLL year via the GraphQL API. Returns
one row per free agent with player identity, team transition info, and
contract status.
}
\usage{
pll_free_agents(year = 2026)
}
\arguments{
  \item{year}{Integer. Year to query. Default \code{2026}. Free agent data
    may be sparse or unavailable before the offseason period for a given
    year.}
}
\value{
A tibble with one row per free agent and 14 snake_case columns:
\describe{
  \item{name}{Character. Full player name.}
  \item{first_name}{Character. Player first name.}
  \item{last_name}{Character. Player last name.}
  \item{slug}{Character. URL-friendly player slug.}
  \item{profile_url}{Character. URL to the player's profile page.}
  \item{age}{Integer. Player age.}
  \item{experience}{Integer. Years of professional experience.}
  \item{position}{Character. Player position abbreviation.}
  \item{status}{Character. Player roster status.}
  \item{official_id}{Character. Unique official player ID.}
  \item{new_contract_status}{Character. Status of the player's new contract
    (e.g., \code{"signed"}, \code{"unsigned"}).}
  \item{new_team_id}{Character. Team ID of the player's new team, or
    \code{NA} if unsigned.}
  \item{prev_team_id}{Character. Team ID of the player's previous team.}
  \item{thirty_percent_threshold_met}{Logical. Whether the player has met
    the 30\% salary threshold rule.}
}
}
\examples{
\dontrun{
# Free agents for the default year (2026)
pll_free_agents()

# Free agents from a past offseason
pll_free_agents(year = 2025)
}
}
