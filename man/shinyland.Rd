% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/landing.R
\name{shinyland}
\alias{shinyland}
\title{Implement a landing page}
\usage{
shinyland(
  navbar_title,
  task_title,
  description_text,
  informed_consent_text,
  task_url
)
}
\arguments{
\item{navbar_title}{The title for the Navigation Bar}

\item{task_title}{The task title}

\item{description_text}{Task description text -- see
\code{\link{make_description}}}

\item{informed_consent_text}{Informed consent language -- see
\code{\link{make_informed_consent}}}

\item{task_url}{The URL for the task where a user will be sent upon agreeing
to participate.}
}
\value{
HTML, CSS, and JavaScript necessary to create a task's landing page.
}
\description{
Implement a landing page
}
\details{
If the \code{task_url} parameter is static, and every visitor to the landing page
will go to one URL, then it may be a simple URL character string. However, if
the visitors to the landing page may be subject to randomization (treatment
groups), you may wish to utilize the \code{\link[shinyrandomize:random_link]{shinyrandomize::random_link()}}
function. This will allow you to define a data frame of group-link
(key-value) pairs which will get updated every time the Shiny app loads. This
is a fine solution. However, this requires the deployed app be dormant
intermittently so the cloud computer hosting the application will reload the
app and update the UI.

#For most cases, I would recommend using \code{\link{autoRandomize}}, which is
placed in the server component of the application. The examples section below
highlights that best practice. For alternatives, see the documentation for
\code{\link{autoRandomize}}.
}
\examples{

# An example of a landing page that will update whenever a user visits the landing page.
# Note the use of the server here. This is the recommended practice to ensure randomization.

if (interactive()) {

  library(shiny)
  library(shinyland)

  # Create a data frame of group-link pairs.
  group_link_pairs <- data.frame(
    group = c("personal", "github"),
    link = c("https://jdtrat.com/",
             "https://github.com/jdtrat")
  )

  ui <- fluidPage(
    shinyland(
      navbar_title = "{shinyland} presents",
      task_title = "A demo task",
      description_text = make_description(
        rawHTML = TRUE,
        '
       <div class = "col-sm-3 box mx-4 p-4 text-center">
       This is an example for creating a landing page.
       This is where a description of the text would go.
       </div>
      '),
      informed_consent_text = make_informed_consent(
        rawHTML = FALSE,
        tags$div("This is an example for creating a landing page.
               This is where Informed Consent language would go.
               In this case, clicking 'Yes, I agree to participate'
               will redirect you to the website https://jdtrat.com."
        )
      ),
      task_url = "https//website-does-not-matter-because-it-will-be-replaced.com"
    )
  )

  server <- function(input, output, session) {
    autoRandomize(groupLinkPairs = group_link_pairs)
  }

  shinyApp(ui, server)

}



}
