\name{pll_events}
\alias{pll_events}
\title{Get PLL Events (Games)}
\description{
Retrieves scheduled and completed game events for a given PLL season year.
Returns one row per game with event metadata, scores, venue info, and
home/away team details.
}
\usage{
pll_events(year = 2025, include_cs = TRUE, include_wll = TRUE)
}
\arguments{
  \item{year}{Integer. Season year. Default \code{2025}. Season data is only
    available for years in which the season has started or completed.}
  \item{include_cs}{Logical. If \code{TRUE} (default), include Champ Series
    events in the results.}
  \item{include_wll}{Logical. If \code{TRUE} (default), include WLL
    (Women's Lacrosse League) events in the results.}
}
\value{
A tibble with one row per game event. Top-level columns include:
\describe{
  \item{id}{Character. Internal event ID.}
  \item{event_id}{Character. Public-facing event ID.}
  \item{league}{Character. League identifier (e.g., \code{"PLL"}).}
  \item{season_segment}{Character. Season segment identifier.}
  \item{start_time}{Character. Event start time (ISO 8601 string).}
  \item{week}{Integer. Week number within the season.}
  \item{year}{Integer. Season year.}
  \item{game_number}{Integer. Game number within the season.}
  \item{venue}{Character. Venue name.}
  \item{venue_location}{Character. Venue city/location.}
  \item{broadcaster}{Character. Broadcast network or streaming platform.}
  \item{event_status}{Character. Event status (e.g., \code{"final"},
    \code{"scheduled"}).}
  \item{game_status}{Character. Detailed game status string.}
  \item{home_score}{Integer. Home team final score.}
  \item{visitor_score}{Integer. Visiting team final score.}
}

Home team columns are prefixed with \code{home_} and away team columns with
\code{away_}. Both sets contain: \code{official_id}, \code{year},
\code{url_logo}, \code{full_name}, \code{location}, \code{location_code},
\code{league}, \code{conference}, \code{team_wins}, \code{team_losses},
\code{team_ties}, \code{seed}, \code{team_color}, \code{background_color}.
}
\examples{
\dontrun{
# All events for the default year (includes Champ Series and WLL)
pll_events()

# PLL-only regular season events for 2024
pll_events(year = 2024, include_cs = FALSE, include_wll = FALSE)
}
}
