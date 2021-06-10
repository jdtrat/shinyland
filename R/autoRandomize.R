
#' Automatically randomize the URL for every visitor
#'
#' @param groupLinkPairs A data frame with two columns "group" and "link"
#'   containing the group and URL links for randomization. See examples for more
#'   details.
#' @param addQueryParameter LOGICAL: TRUE and a query parameter "group_id" will
#'   be added to the randomization URL. FALSE and it won't.
#'
#' @return NA; used for side effects
#' @export
#'
#' @examples
#'
#'
#' # An example of a static website where the `task_url` parameter can be passed
#' # in as a character string.
#'
#' if (interactive()) {
#'
#'   library(shiny)
#'   library(shinyland)
#'
#'   ui <- fluidPage(
#'     shinyland(
#'       navbar_title = "{shinyland} presents",
#'       task_title = "A demo task",
#'       description_text = make_description(
#'         rawHTML = TRUE,
#'         '
#'        <div class = "col-sm-3 box mx-4 p-4 text-center">
#'        This is an example for creating a landing page.
#'        This is where a description of the text would go.
#'        </div>
#'       '),
#'       informed_consent_text = make_informed_consent(
#'         rawHTML = FALSE,
#'         tags$div("This is an example for creating a landing page.
#'                This is where Informed Consent language would go.
#'                In this case, clicking 'Yes, I agree to participate'
#'                will redirect you to the website https://jdtrat.com."
#'         )
#'       ),
#'       task_url = "https://jdtrat.com"
#'     )
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'   }
#'
#'   shinyApp(ui, server)
#'
#' }
#'
#' # An example of a landing page that will randomize the URL only when the
#' # cloud computer re-runs the app after a dormant period.
#'
#' if (interactive()) {
#'
#'   library(shiny)
#'   library(shinyland)
#'
#'   # Create a data frame of group-link pairs.
#'   group_link_pairs <- data.frame(
#'     group = c("personal", "github"),
#'     link = c("https://jdtrat.com/",
#'              "https://github.com/jdtrat")
#'   )
#'
#'   ui <- fluidPage(
#'     shinyland(
#'       navbar_title = "{shinyland} presents",
#'       task_title = "A demo task",
#'       description_text = make_description(
#'         rawHTML = TRUE,
#'         '
#'        <div class = "col-sm-3 box mx-4 p-4 text-center">
#'        This is an example for creating a landing page.
#'        This is where a description of the text would go.
#'        </div>
#'       '),
#'       informed_consent_text = make_informed_consent(
#'         rawHTML = FALSE,
#'         tags$div("This is an example for creating a landing page.
#'                This is where Informed Consent language would go.
#'                In this case, clicking 'Yes, I agree to participate'
#'                will redirect you to the website https://jdtrat.com."
#'         )
#'       ),
#'       task_url = shinyrandomize::random_link(groupLinkPairs = group_link_pairs)
#'     )
#'   )
#'
#'   server <- function(input, output, session) {
#'
#'   }
#'
#'   shinyApp(ui, server)
#'
#' }
#'
#'
#' # An example of a landing page that will update whenever a user visits the
#' # landing page. Note the use of the server here. This is the recommended
#' # practice to ensure randomization.
#'
#' if (interactive()) {
#'
#'   library(shiny)
#'   library(shinyland)
#'
#'   # Create a data frame of group-link pairs.
#'   group_link_pairs <- data.frame(
#'     group = c("personal", "github"),
#'     link = c("https://jdtrat.com/",
#'              "https://github.com/jdtrat")
#'   )
#'
#'   ui <- fluidPage(
#'     shinyland(
#'       navbar_title = "{shinyland} presents",
#'       task_title = "A demo task",
#'       description_text = make_description(
#'         rawHTML = TRUE,
#'         '
#'        <div class = "col-sm-3 box mx-4 p-4 text-center">
#'        This is an example for creating a landing page.
#'        This is where a description of the text would go.
#'        </div>
#'       '),
#'       informed_consent_text = make_informed_consent(
#'         rawHTML = FALSE,
#'         tags$div("This is an example for creating a landing page.
#'                This is where Informed Consent language would go.
#'                In this case, clicking 'Yes, I agree to participate'
#'                will redirect you to the website https://jdtrat.com."
#'         )
#'       ),
#'       task_url = "https://website-does-not-matter-because-it-will-be-replaced.com"
#'     )
#'   )
#'
#'   server <- function(input, output, session) {
#'     autoRandomize(groupLinkPairs = group_link_pairs)
#'   }
#'
#'   shinyApp(ui, server)
#'
#' }
#'
#'
#'
#'
#'
autoRandomize <- function(groupLinkPairs, addQueryParameter = TRUE) {

  session <- shiny::getDefaultReactiveDomain()

  randomLink <-  shinyrandomize::random_link(
    groupLinkPairs = groupLinkPairs,
    addQueryParameter = addQueryParameter)

  shiny::observeEvent(session$input$getStartedClicked, {
    session$sendCustomMessage("updateRandomLink", randomLink)
    })

  shiny::observeEvent(session$input$consentTabClicked, {
    session$sendCustomMessage("updateRandomLink", randomLink)
  })

}
