\name{pll_draft_predictions}
\alias{pll_draft_predictions}
\title{Get PLL Draft Predictions}
\description{
Retrieves analyst mock draft rankings and predictions for a given PLL draft
year. These are analyst opinions, not official picks. For official draft
selections use \code{\link{pll_draft_order}}.
}
\usage{
pll_draft_predictions(year = 2026)
}
\arguments{
  \item{year}{Integer. Draft year to retrieve predictions for.
    Default \code{2026}.}
}
\value{
A tibble with one row per predicted pick and 13 columns:
\describe{
  \item{id}{Character. Unique record ID.}
  \item{year}{Integer. Draft year.}
  \item{analyst_name}{Character. Name of the analyst or source.}
  \item{player_name}{Character. Predicted player name.}
  \item{image_url}{Character. URL to the player's image.}
  \item{position}{Character. Player position.}
  \item{college}{Character. Player's college.}
  \item{college_logo}{Character. URL to the college's logo.}
  \item{overall_rank}{Integer. Analyst's overall draft ranking for the player.}
  \item{position_rank}{Integer. Ranking within the player's position group.}
  \item{change}{Integer. Change in rank since the last update.}
  \item{analysis}{Character. Analyst write-up or scouting notes.}
  \item{league}{Character. League identifier.}
}
}
\examples{
\dontrun{
# Mock draft predictions for 2026 (default)
pll_draft_predictions()

# Predictions for a past draft year
pll_draft_predictions(year = 2025)
}
}
