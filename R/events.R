#' Get PLL Events (Games)
#'
#' @title Get PLL Events (Games)
#'
#' @description Retrieves scheduled and completed game events for a given PLL
#'   season year. Returns one row per game with event metadata, scores, venue
#'   info, and home/away team details.
#'
#' @param year Integer. Season year. Default `2025`. Season data is only
#'   available for years in which the season has started or completed.
#' @param include_cs Logical. If `TRUE` (default), include Champ Series events
#'   in the results.
#' @param include_wll Logical. If `TRUE` (default), include WLL (Women's
#'   Lacrosse League) events in the results.
#'
#' @return A tibble with one row per game event. Top-level columns include:
#'   \describe{
#'     \item{id}{Character. Internal event ID.}
#'     \item{event_id}{Character. Public-facing event ID.}
#'     \item{league}{Character. League identifier (e.g., `"PLL"`).}
#'     \item{season_segment}{Character. Season segment identifier.}
#'     \item{start_time}{Character. Event start time (ISO 8601 string).}
#'     \item{week}{Integer. Week number within the season.}
#'     \item{year}{Integer. Season year.}
#'     \item{game_number}{Integer. Game number within the season.}
#'     \item{venue}{Character. Venue name.}
#'     \item{venue_location}{Character. Venue city/location.}
#'     \item{broadcaster}{Character. Broadcast network or streaming platform.}
#'     \item{event_status}{Character. Event status (e.g., `"final"`, `"scheduled"`).}
#'     \item{game_status}{Character. Detailed game status string.}
#'     \item{home_score}{Integer. Home team score.}
#'     \item{visitor_score}{Integer. Visiting team score.}
#'   }
#'   Home team columns are prefixed with `home_` and away team columns with
#'   `away_`. Both sets include: `official_id`, `year`, `url_logo`,
#'   `full_name`, `location`, `location_code`, `league`, `conference`,
#'   `team_wins`, `team_losses`, `team_ties`, `seed`, `team_color`,
#'   `background_color`.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # All events for the default year (includes Champ Series and WLL)
#' pll_events()
#'
#' # PLL-only regular season events for 2024
#' pll_events(year = 2024, include_cs = FALSE, include_wll = FALSE)
#' }
pll_events <- function(year = 2025, include_cs = TRUE, include_wll = TRUE) {
  params <- list(
    year       = year,
    includeCS  = tolower(as.character(include_cs)),
    includeWLL = tolower(as.character(include_wll))
  )

  resp  <- .pll_rest_get("/events", params)
  items <- resp$data$items

  if (is.null(items) || length(items) == 0) {
    return(tibble::tibble())
  }

  rows <- lapply(items, .flatten_event)
  dplyr::bind_rows(rows)
}

.flatten_team_side <- function(team, prefix) {
  if (is.null(team)) team <- list()
  stats <- list(
    official_id      = .safe_val(team, "officialId"),
    year             = .safe_val(team, "year"),
    url_logo         = .safe_val(team, "urlLogo"),
    full_name        = .safe_val(team, "fullName"),
    location         = .safe_val(team, "location"),
    location_code    = .safe_val(team, "locationCode"),
    league           = .safe_val(team, "league"),
    conference       = .safe_val(team, "conference"),
    team_wins        = .safe_val(team, "teamWins"),
    team_losses      = .safe_val(team, "teamLosses"),
    team_ties        = .safe_val(team, "teamTies"),
    seed             = .safe_val(team, "seed"),
    team_color       = .safe_val(team, "teamColor"),
    background_color = .safe_val(team, "backgroundColor")
  )
  names(stats) <- paste0(prefix, names(stats))
  stats
}

.flatten_event <- function(x) {
  home_fields <- .flatten_team_side(x$homeTeam, "home_")
  away_fields <- .flatten_team_side(x$awayTeam, "away_")

  top <- list(
    id                  = .safe_val(x, "id"),
    slugname            = .safe_val(x, "slugname"),
    event_id            = .safe_val(x, "eventId"),
    external_id         = .safe_val(x, "externalId"),
    league              = .safe_val(x, "league"),
    season_segment      = .safe_val(x, "seasonSegment"),
    start_time          = .safe_val(x, "startTime"),
    week                = .safe_val(x, "week"),
    year                = .safe_val(x, "year"),
    game_number         = .safe_val(x, "gameNumber"),
    location            = .safe_val(x, "location"),
    venue               = .safe_val(x, "venue"),
    venue_location      = .safe_val(x, "venueLocation"),
    url_streaming       = .safe_val(x, "urlStreaming"),
    url_ticket          = .safe_val(x, "urlTicket"),
    url_preview         = .safe_val(x, "urlPreview"),
    broadcaster         = .safe_val(x, "broadcaster"),
    add_to_calendar_id  = .safe_val(x, "addToCalendarId"),
    description         = .safe_val(x, "description"),
    weekend_ticket_id   = .safe_val(x, "weekendTicketId"),
    suite_id            = .safe_val(x, "suiteId"),
    waitlist_url        = .safe_val(x, "waitlistUrl"),
    waitlist            = .safe_val(x, "waitlist"),
    event_status        = .safe_val(x, "eventStatus"),
    period              = .safe_val(x, "period"),
    clock_minutes       = .safe_val(x, "clockMinutes"),
    clock_seconds       = .safe_val(x, "clockSeconds"),
    clock_tenths        = .safe_val(x, "clockTenths"),
    game_status         = .safe_val(x, "gameStatus"),
    external_event_id   = .safe_val(x, "externalEventId"),
    visitor_score       = .safe_val(x, "visitorScore"),
    home_score          = .safe_val(x, "homeScore"),
    ticket_id           = .safe_val(x, "ticketId"),
    snl                 = .safe_val(x, "snl")
  )

  as_row <- c(top, home_fields, away_fields)
  tibble::as_tibble(lapply(as_row, function(v) if (is.null(v)) NA else v))
}
