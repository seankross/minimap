#' Same sex marriage in the US
#'
#' Changes in the legality of same sex marriage in the United States over time.
#'
#' @source \url{http://www.nytimes.com/interactive/2015/03/04/us/gay-marriage-state-by-state.html}
#' @format A data frame with columns:
#' \describe{
#'  \item{state}{State Abbreviation}
#'  \item{status}{Legal status. Either \code{bbs} meaning banned by statute,
#'    \code{nl} meaning not legal, \code{legal}, \code{bbca} meaning banned by
#'    constitutional ammendment, or \code{dis} meaning disputed.}
#'  \item{year}{Year status went into effect.}
#' }
#' @examples
#' \dontrun{
#'  ssm
#' }
"ssm"
