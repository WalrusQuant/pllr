\name{pll_standings}
\alias{pll_standings}
\title{Get PLL Standings}
\description{
Retrieves team standings for a given PLL season year and segment. Returns
one row per team with win/loss records, score totals, and conference
breakdown.
}
\usage{
pll_standings(year = 2025, champ_series = TRUE)
}
\arguments{
  \item{year}{Integer. Season year. Default \code{2025}. Season data is only
    available for years in which the season has started or completed.}
  \item{champ_series}{Logical. If \code{TRUE} (default), returns Champ Series
    standings. If \code{FALSE}, returns regular season standings.}
}
\value{
A tibble with one row per team and 19 snake_case columns:
\describe{
  \item{team_id}{Character. Unique team identifier.}
  \item{full_name}{Character. Full team name (e.g., \code{"Atlas LC"}).}
  \item{location}{Character. Team city/location name.}
  \item{location_code}{Character. Short location code.}
  \item{url_logo}{Character. URL to the team logo image.}
  \item{seed}{Integer. Team seed in the standings.}
  \item{wins}{Integer. Total wins.}
  \item{losses}{Integer. Total losses.}
  \item{ties}{Integer. Total ties.}
  \item{scores}{Integer. Total goals scored.}
  \item{scores_against}{Integer. Total goals allowed.}
  \item{score_diff}{Integer. Goal differential (scores - scores_against).}
  \item{conference_wins}{Integer. Conference wins.}
  \item{conference_losses}{Integer. Conference losses.}
  \item{conference_ties}{Integer. Conference ties.}
  \item{conference_scores}{Integer. Goals scored in conference games.}
  \item{conference_scores_against}{Integer. Goals allowed in conference games.}
  \item{conference}{Character. Conference name.}
  \item{conference_seed}{Integer. Seed within the team's conference.}
}
}
\examples{
\dontrun{
# Champ Series standings for the current default year
pll_standings()

# Regular season standings for 2024
pll_standings(year = 2024, champ_series = FALSE)
}
}
