library(shiny)
library(markdown) #includeMarkdown()
library(shinyAce) #updateAceEditor()

fig_list_raw <- read.delim(file.path("data", "figure-list.tsv"),
                           colClasses = "character")

# move cmeg figures to the bottom
fig_list <- dplyr::arrange(fig_list_raw, CMEG)

# get thumbnail files
thumbs <- file.path("thumbnails", paste0(fig_list$basename, "_thumb.png"))

# make HTML element for each figure 
thumbs_src <- paste0('<img class="chart" src="',
                     thumbs, '" data-code="', fig_list$basename, '"></img>')

# check if thumbnail file exists ,
# if its not there, replace with name of file
ind <- basename(thumbs) %in% list.files(file.path("www", "thumbnails"))

thumbs_src[!ind] <- basename(thumbs)[!ind]

#' Pad vector so its length is multiple of 3 (the # of cols of display matrix)
#'
#' @param x a vector
#'
#' @return vector of length multiple of 3
pad_with_na <- function(x) 
{
  # determine length of padding needed to fill matrix of ncol = 3
  n <- 3 * ceiling(length(x) / 3) - length(x)
  x_padded <- c(x, rep(NA, n))
  x_padded
}

shinyServer(function(input, output, session){
  
  plottypeInput <- reactive({
    
    select_items <- c(input$type, input$plottype, input$element, input$chapter)
    
    if(length(select_items) == 0) {
      # nothing is selected, so show everything
      all_thumbs <- pad_with_na(thumbs_src)
      matrix(all_thumbs, ncol = 3, byrow = TRUE)
    } else {
      selected_items <- list("type" = input$type, "plottype" = input$plottype,
                             "element" = input$element, "chapter" = input$chapter)
      # find figure index in fig_list where tag appears
      fig_indices_list <- 
        plyr::llply(selected_items, 
                    function(grp) {
                      list1 <- plyr::llply(grp, function(k) {
                        ind <- which(grepl(k, fig_list$tags, ignore.case = TRUE))
                      })
                      unlist(list1)
                    })
      
      # remove NULL elements
      fig_indices_clean <- 
        fig_indices_list[!unlist(lapply(fig_indices_list, is.null))]
      
      fig_indices <- Reduce(intersect, fig_indices_clean)
      fig_indices_padded <- pad_with_na(fig_indices)
      
      quotient <- length(fig_indices_padded)/3
      
      if(quotient > 0) {
        matrix(thumbs_src[fig_indices_padded], 
               ncol = 3, nrow = quotient, byrow = TRUE)
      } else {
        no_match <- "There are no graphs that match the selected criteria."
        # return empty matrix to avoid console warning
        matrix(no_match, nrow = 1, ncol = 1) 
      }
    }
  })
  
  output$mytable <- renderTable({ 
    plottypeInput()
  }, sanitize.text.function = function(x) x,
  include.colnames = FALSE, include.rownames = FALSE
  )
  
  output$figImage <- renderImage({
    if(length(values$code) == 0) {
      filename <- normalizePath(file.path('www',
                                          paste("please-select-figure.png")))
    } else {
      filename <- normalizePath(file.path('www/figures',
                                          paste0(values$code, ".png")))
    }
    list(src = filename)
  }, deleteFile = FALSE)
  
  output$figImage_only <- renderImage({
    if(length(values$code) == 0) {
      filename <- normalizePath(file.path('www',
                                          paste("please-select-figure.png")))
    } else {
      filename <- normalizePath(file.path('www', 'figures',
                                          paste0(values$code, ".png")))
    }
    list(src = filename,
         width = 600)
  }, deleteFile = FALSE)
  
  output$code_only <- reactive({
    x <- "Please select a figure."
    if (length(values$code) > 0) {
      # get contents of figure R file
      r_file <- file.path('data', paste0(values$code, ".R"))
      x <- includeText(r_file)
    }
    
    editor <- aceEditor("code_only_editor", value = x, mode = "r",
                        readOnly = TRUE)
    editor <- gsub("\n", "", editor)
    editor
  })
  
  output$link <- renderText({
    if(length(values$code > 0)) {
      repo <- paste0("https://github.com/jennybc/r-graph-catalog/tree/master/figures/",
                     values$code)
      
      target <- paste('target="_blank"')
      
      link <- paste(a("Go to GitHub to download figure and code",
                      href = paste(repo), target = "_blank"))
      link 
    }
  })
  
  # Create a reactiveValues object, to let us use settable reactive values
  values <- reactiveValues()
  values$clicked <- FALSE
  values$code <- NULL
  
  observe({
    if (!is.null(input$clicked) && input$clicked == TRUE) {
      values$code <- input$code
      
      # get contents of figure R file
      r_file <- file.path('data', paste0(values$code, ".R"))
      x <- includeText(r_file)
      
      updateAceEditor(session, "fig_and_code", mode="r", value = x)
      updateTabsetPanel(session, "tabset", selected = "Figure & Code")
    }
  })
})
