#' Implement a landing page
#'
#' @param navbar_title The title for the Navigation Bar
#' @param task_title The task title
#' @param description_text Task description text -- see \code{\link{make_description}}
#' @param informed_consent_text Informed consent language -- see \code{\link{make_informed_consent}}
#' @param task_url The URL for the task where a user will be sent upon agreeing to participate.
#'
#' @return HTML, CSS, and JavaScript necessary to create a task's landing page.
#' @export
#'
shinyland <- function(navbar_title, task_title, description_text, informed_consent_text, task_url) {

  shiny::tagList(
    htmltools::htmlDependency(
      name = "landingPage",
      version = utils::packageVersion("shinyland"),
      package = "shinyland",
      src = "assets",
      script = c("js/jquery-1.12.4.min.js", "js/bootstrap-4.6.0.min.js"),
      stylesheet = c("css/bootstrap-4.6.0.min.css")
    ),
    make_landing(navbar_title = navbar_title,
                 task_title = task_title,
                 description_text = description_text,
                 informed_consent_text = informed_consent_text,
                 task_url = task_url)
  )

}

shiny::icon


