#' Get PLL Free Agents
#'
#' @title Get PLL Free Agents
#'
#' @description Retrieves free agent data for a given PLL year via the GraphQL
#'   API. Returns one row per free agent with player identity, team transition
#'   info, and contract status.
#'
#' @param year Integer. Year to query. Default `2026`. Free agent data may be
#'   sparse or unavailable before the offseason period for a given year.
#'
#' @return A tibble with one row per free agent and 14 snake_case columns:
#'   \describe{
#'     \item{name}{Character. Full player name.}
#'     \item{first_name}{Character. Player first name.}
#'     \item{last_name}{Character. Player last name.}
#'     \item{slug}{Character. URL-friendly player slug.}
#'     \item{profile_url}{Character. URL to the player's profile page.}
#'     \item{age}{Integer. Player age.}
#'     \item{experience}{Integer. Years of professional experience.}
#'     \item{position}{Character. Player position abbreviation.}
#'     \item{status}{Character. Player roster status.}
#'     \item{official_id}{Character. Unique official player ID.}
#'     \item{new_contract_status}{Character. Status of the player's new
#'       contract (e.g., `"signed"`, `"unsigned"`).}
#'     \item{new_team_id}{Character. Team ID of the player's new team, or
#'       `NA` if unsigned.}
#'     \item{prev_team_id}{Character. Team ID of the player's previous team.}
#'     \item{thirty_percent_threshold_met}{Logical. Whether the player has met
#'       the 30% salary threshold rule.}
#'   }
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # Free agents for the default year (2026)
#' pll_free_agents()
#'
#' # Free agents from a past offseason
#' pll_free_agents(year = 2025)
#' }
pll_free_agents <- function(year = 2026) {
  query <- "
    query($year: Int!) {
      freeAgents(year: $year) {
        player {
          name
          firstName
          lastName
          slug
          profileUrl
          age
          experience
          position
          status
        }
        officialId
        newContractStatus
        newTeamId
        prevTeamId
        thirtyPercentThresholdMet
      }
    }
  "

  resp     <- .pll_graphql_query(query, variables = list(year = year))
  agents   <- resp$data$freeAgents

  if (is.null(agents) || length(agents) == 0) {
    return(.empty_free_agents_tibble())
  }

  rows <- lapply(agents, .flatten_free_agent)
  dplyr::bind_rows(rows)
}

.flatten_free_agent <- function(x) {
  player <- x$player %||% list()

  tibble::tibble(
    name                         = .safe_val(player, "name"),
    first_name                   = .safe_val(player, "firstName"),
    last_name                    = .safe_val(player, "lastName"),
    slug                         = .safe_val(player, "slug"),
    profile_url                  = .safe_val(player, "profileUrl"),
    age                          = .safe_val(player, "age"),
    experience                   = .safe_val(player, "experience"),
    position                     = .safe_val(player, "position"),
    status                       = .safe_val(player, "status"),
    official_id                  = .safe_val(x, "officialId"),
    new_contract_status          = .safe_val(x, "newContractStatus"),
    new_team_id                  = .safe_val(x, "newTeamId"),
    prev_team_id                 = .safe_val(x, "prevTeamId"),
    thirty_percent_threshold_met = .safe_val(x, "thirtyPercentThresholdMet")
  )
}

.empty_free_agents_tibble <- function() {
  tibble::tibble(
    name                         = character(),
    first_name                   = character(),
    last_name                    = character(),
    slug                         = character(),
    profile_url                  = character(),
    age                          = integer(),
    experience                   = integer(),
    position                     = character(),
    status                       = character(),
    official_id                  = character(),
    new_contract_status          = character(),
    new_team_id                  = character(),
    prev_team_id                 = character(),
    thirty_percent_threshold_met = logical()
  )
}
