#' Render Landing Page
#'
#' Internal function for rendering landing page using {whisker}
#'
#' @inheritParams shinyland
#'
#' @keywords internal
#' @noRd
#'
#' @return Rendered HTML of a Landing Page for use in a {shiny} application.
#'
make_landing <- function(navbar_title, task_title, description_text, informed_consent_text, task_url) {

  template <- readLines(system.file("landing-template.html", package = "shinyland"))
  data <- list(
    navbar_title = navbar_title,
    task_title = task_title,
    description_text = description_text,
    informed_consent_text = informed_consent_text,
    task_url = task_url
  )

  shiny::HTML(
    whisker::whisker.render(template, data)
  )

}

#' Make Description Text
#'
#' @param rawHTML Logical: FALSE by default. If TRUE, raw HTML string should be
#'   supplied. FALSE and {shiny} functions should be utilized to create text.
#' @param ... Character string of HTML or {shiny} functions
#'
#' @return HTML for description text in landing page.
#' @export
#'
#' @examples
#'
#'
#' if (interactive()) {
#'
#' # To use {shiny} functions
#'
#' make_description(rawHTML = FALSE,
#' tagList(
#'  column(3, p( "You have been selected to participate in a task that does...")),
#'  column(3, p("This task will take approximately ... it is optional..."))
#' )
#' )
#'
#' # To use HTML
#'
#' make_description(rawHTML = TRUE,
#''
#'      <div class = "col-sm-3 box mx-4 p-4 text-center">
#'        You have been selected to participate in a task that does...
#'      </div>
#'      <div class = "col-sm-3 box mx-4 p-4 text-center">
#'       <center>
#'          <p>This task will take approximately ... it is optional...</p>
#'        </center>
#'      </div>
#'      <div class = "col-sm-3 box mx-4 p-4 text-center">
#'       <center>
#'          <p>You will be compensated ... </p>
#'        </center>
#'      </div>
#'  ')
#'
#' }
#'
#'
make_description <- function(rawHTML = FALSE, ...) {
  if (rawHTML) {
   shiny::HTML(...)
  } else {
   eval(substitute(...))
  }
}

#' Make Informed Consent Text
#'
#' @inheritParams make_description
#' @seealso make_description
#'
#' @return HTML for informed consent text in landing page.
#'
#' @export
#'
make_informed_consent <- function(rawHTML = FALSE, ...) {
  if (rawHTML) {
    shiny::HTML(...)
  } else {
    eval(substitute(...))
  }
}
