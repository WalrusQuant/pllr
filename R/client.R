# Internal HTTP client for the PLL stats API
#
# REST base URL and GraphQL endpoint
.PLL_REST_BASE  <- "https://api.stats.premierlacrosseleague.com/api/v4"
.PLL_GRAPHQL_URL <- "https://api.stats.premierlacrosseleague.com/graphql"

# Auth tokens
.PLL_REST_TOKEN    <- "2<b}_K/x8JU1mn/"
.PLL_GRAPHQL_TOKEN <- "N)eIKy1rZ%/%fm1WhM7tuVcrR*UIsc"

#' @importFrom httr2 request req_headers req_url_query req_perform resp_body_json req_body_json req_method
#' @importFrom rlang abort
NULL

# Null-coalescing operator (not exported from rlang in all versions)
`%||%` <- function(x, y) if (is.null(x)) y else x

# Internal: camelCase -> snake_case conversion
.to_snake_case <- function(x) {
  # Insert underscore before uppercase letters that follow a lowercase letter or digit
  x <- gsub("([a-z0-9])([A-Z])", "\\1_\\2", x)
  # Insert underscore before sequences of uppercase letters followed by lowercase (e.g. URLName -> URL_Name)
  x <- gsub("([A-Z]+)([A-Z][a-z])", "\\1_\\2", x)
  tolower(x)
}

# Internal: GET a REST endpoint and return parsed JSON
.pll_rest_get <- function(path, params = list()) {
  url <- paste0(.PLL_REST_BASE, path)

  req <- httr2::request(url) |>
    httr2::req_headers(
      Authorization  = paste("Bearer", .PLL_REST_TOKEN),
      authSource     = "stats",
      `Content-Type` = "application/json"
    )

  if (length(params) > 0) {
    req <- httr2::req_url_query(req, !!!params)
  }

  resp <- tryCatch(
    httr2::req_perform(req),
    error = function(e) {
      rlang::abort(
        paste0("PLL REST request failed for '", path, "': ", conditionMessage(e))
      )
    }
  )

  httr2::resp_body_json(resp, simplifyVector = FALSE)
}

# Internal: POST a GraphQL query and return parsed JSON
.pll_graphql_query <- function(query, variables = list()) {
  body <- list(query = query, variables = variables)

  req <- httr2::request(.PLL_GRAPHQL_URL) |>
    httr2::req_method("POST") |>
    httr2::req_headers(
      Authorization  = paste("Bearer", .PLL_GRAPHQL_TOKEN),
      `Content-Type` = "application/json"
    ) |>
    httr2::req_body_json(body)

  resp <- tryCatch(
    httr2::req_perform(req),
    error = function(e) {
      rlang::abort(
        paste0("PLL GraphQL request failed: ", conditionMessage(e))
      )
    }
  )

  parsed <- httr2::resp_body_json(resp, simplifyVector = FALSE)

  if (!is.null(parsed$errors)) {
    msgs <- vapply(parsed$errors, function(e) e$message %||% "unknown error", character(1))
    rlang::abort(paste0("GraphQL errors: ", paste(msgs, collapse = "; ")))
  }

  parsed
}

# Internal: safely extract a value from a list, returning NA if missing/NULL
.safe_val <- function(x, key, default = NA) {
  val <- x[[key]]
  if (is.null(val)) default else val
}
