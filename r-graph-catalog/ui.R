library(shiny)
library(shinyAce)

## Function from Joe Cheng
## https://gist.github.com/jcheng5/5913297
helpPopup <- function(title, content,
                      placement = c('right', 'top', 'left', 'bottom'),
                      trigger = c('click', 'hover', 'focus', 'manual')) {
  tagList(
    singleton(
      tags$head(
        tags$script("$(function() { $(\"[data-toggle='popover']\").popover()})"),
        tags$style(type = "text/css", ".popover{max-width:500px; position: fixed;}")
      )
    ),
    tags$a(
      href = "#", class = "btn btn-link",
      `data-toggle` = "popover", `data-html` = "true",
      title = title, `data-content` = content, `data-animation` = TRUE,
      `data-placement` = match.arg(placement, several.ok = TRUE)[1],
      `data-trigger` = match.arg(trigger, several.ok = TRUE)[1],
      "More..."
    )
  )
}

shinyUI(fluidPage(
  
  tags$head(includeScript(file.path("www", "js", "app.js"))#,
            #includeScript(file.path("www", "js", "google-analytics.js"))
  ),
  
  includeCSS(file.path("www", "css", "app.css")),
  
  titlePanel("R Graph Catalog"),
  sidebarLayout(
    sidebarPanel(
      id = "sidepanel",
      width = 3,
      h3("About"),
      includeMarkdown("about.md"),
      tags$div(id = "popup",
               helpPopup(strong("Additional Information"),
                         includeMarkdown("about-extended.md"),
                         placement = "right", trigger = "click")),
      br(),
      checkboxGroupInput("type", strong("Filter by type"),
                         choices = c("Good", "Not Recommended"),
                         selected = list()),
      
      checkboxGroupInput("plottype", strong("Filter by tags"),
                         choices =
                           c("Dot Plot", "Line Graph", "Pie Chart",
                             "Bar Chart", "Scatterplot", "Trellis Display",
                             "Histogram", "Boxplot", "Timeseries", "Table",
                             "Bubble Chart", "Month Plot", "Area Plot",
                             "Waffle Chart", "Heatmap"),
                         selected = list()),
      
      checkboxGroupInput("element", strong("Filter by graph elements"),
                         choices =
                           c("Annotation", "Footnote", "Multiple Plots",
                             "Data Labels", "Loess Smoothing", "Jitter",
                             "Legend", "Subscript", "Transparency", "Themes"),
                         selected = list()),
      
      checkboxGroupInput("chapter", strong("Filter by chapter"),
                         choices =
                           c("ch01_intro", "ch02_limitations", "ch03_perception",
                             "ch04_1or2dim", "ch05_morethan2var",
                             "ch06_general", "ch07_scales", "ch08_beforeafter",
                             "ch09_software", "ch10_qanda", "ggplot2_tutorial", 
                             "other"),
                         selected = list())
    ),
    
    mainPanel(
      width = 9,
      tabsetPanel(
        id = "tabset",
        tabPanel("Catalog", tableOutput("mytable")),
        tabPanel("Figure & Code",
                 fluidRow(
                   column(width = 6, imageOutput("figImage", height = "auto")),
                   column(width = 6,
                          aceEditor("fig_and_code",
                                    value = "Please select a figure" ,
                                    readOnly = TRUE, height = "450px"),
                          htmlOutput("link")))),
        tabPanel("Figure", imageOutput("figImage_only")),
        tabPanel("Code", htmlOutput("code_only"))
      )
      
      
    )
  )
))

