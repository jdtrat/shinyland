
#' Load shinyland's required resources
#'
#' @return NA; used to load web resources.
#' @export
#'
use_shinyland <- function() {

  shiny::tagList(
    htmltools::htmlDependency(
      name = "landingPage",
      version = utils::packageVersion("shinyland"),
      package = "shinyland",
      src = "assets",
      script = c("js/jquery-1.12.4.min.js", "js/bootstrap-4.6.0.min.js"),
      stylesheet = c("css/bootstrap-4.6.0.min.css", "css/fontawesome-all.css", "css/landing.css")
    )
  )

}

