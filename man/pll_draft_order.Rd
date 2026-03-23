\name{pll_draft_order}
\alias{pll_draft_order}
\title{Get PLL Draft Order}
\description{
Retrieves the official draft pick order for a given PLL draft year and
league. Returns one row per draft slot with team ownership and, once the
draft has occurred, the player selected at each slot.
}
\usage{
pll_draft_order(year = 2025, league = "PLL")
}
\arguments{
  \item{year}{Integer. Draft year. Default \code{2025}.}
  \item{league}{Character. League identifier. Default \code{"PLL"}.}
}
\value{
A tibble with one row per draft slot and 11 columns:
\describe{
  \item{id}{Character. Unique identifier for this draft slot record.}
  \item{year}{Integer. Draft year.}
  \item{round}{Integer. Draft round number.}
  \item{round_pick}{Integer. Pick number within the round.}
  \item{overall_pick}{Integer. Overall pick number across all rounds.}
  \item{team_id}{Character. ID of the team holding the pick.}
  \item{league}{Character. League identifier.}
  \item{pick_player_name}{Character. Name of the drafted player, or
    \code{NA} if the slot has not yet been filled.}
  \item{pick_college}{Character. Player's college, or \code{NA} if unfilled.}
  \item{pick_position}{Character. Player's position, or \code{NA} if unfilled.}
  \item{pick_player_id}{Character. Player ID, or \code{NA} if unfilled.}
}
}
\examples{
\dontrun{
# Official 2025 PLL draft order with picks filled in
pll_draft_order()

# 2026 draft order (pick columns may be NA before the draft)
pll_draft_order(year = 2026, league = "PLL")
}
}
