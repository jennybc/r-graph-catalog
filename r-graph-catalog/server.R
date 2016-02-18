library(shiny)
library(markdown) #includeMarkdown()
library(plyr) #llply()
library(shinyAce) #updateAceEditor()

fig_list <- read.delim(file.path("data", "figure-list.tsv"),
                       colClasses = "character")

# get thumbnail files
thumbs <- file.path("thumbnails", paste0(fig_list$basename, "_thumb.png"))
#thumbs <- file.path("figures", paste0(fig_list$basename, ".png"))

# get figure basenames from thumbnails and make HTML element for each figure
thumbs_src <- paste0('<img class="chart" src="',
                     thumbs, '" data-code="', fig_list$basename, '"></img>')

# vector of figures used to fill matrix
txt <- paste(thumbs_src)

# check if thumbnail file exists ,
# if its not there, replace with name of file
ind <- basename(thumbs) %in% list.files(file.path("www", "thumbnails"))
#ind <- basename(thumbs) %in% list.files(file.path("www", "figures"))

txt[!ind] <- basename(thumbs)[!ind]


filter.tags <- function(x) {
  # Get filtered figures based on list of tags selected.
  #
  # Args:
  #   x: list of tags selected
  #
  # Returns:
  #   A matrix containing filtered figures.
  list_of_ind <- llply(x, function(x) which(grepl(x, fig_list$tags, ignore.case = TRUE)))
  #id_ind <- Reduce(intersect, list_of_ind) # intersection
  ind_set <- unique(unlist(list_of_ind)) # get set
  ind_set
}

delete.NULLs  <-  function(x_list) {
  # Remove empty elements from list
  #
  # Args:
  #   x.list: list
  #
  # Returns:
  #   List with no empty elements
  x_list[unlist(lapply(x_list, length) != 0)]
}

pad.Vector <- function(x) {
  # Pad vector so its length is multiple of 3
  # (the # of cols of display matrix)
  #
  # Args:
  #   x: vector
  #
  # Returns:
  #   Vector of length multiple of 3

  # determine length of padding needed to fill matrix of ncol = 3
  n <- 3 * ceiling(length(x) / 3) - length(x)

  x_padded <- c(x, rep(NA, n))
  x_padded

}


shinyServer(function(input, output, session){

  datasetInput <- reactive({
    if((length(input$type) + length(input$dataset) + length(input$element) +
          length(input$chapter)) == 0) {

      txt_padded <- pad.Vector(txt)
      mat <- matrix(txt_padded , ncol = 3, byrow = TRUE)

    } else {
      index_type <- as.list(input$type) # indices of selected type
      index_tags <-	as.list(input$dataset) # indices of selected tags
      index_elem <- as.list(input$element) # indices of selected elements
      index_chap <- as.list(input$chapter) # indices of selected chapters

      list_of_indices <- list(filter.tags(index_type),
                              filter.tags(index_tags),
                              filter.tags(index_elem),
                              filter.tags(index_chap))

      # remove empty elements from list of indices
      list_of_indices_clean <- delete.NULLs(list_of_indices)

      index_final <- Reduce(intersect, list_of_indices_clean)

      index_padded <- pad.Vector(index_final)

      if(length(index_padded)/3 > 0) {
        matrix(txt[index_padded], ncol = 3, nrow = (length(index_padded)/3), byrow = TRUE)
      } else {
        empty_figs <- "There are no graphs that match the selected criteria."
        matrix(empty_figs, nrow = 1, ncol = 1) # return empty matrix to avoid console warning
      }
    }
  })

  output$mytable <- renderTable({

    dataset <- datasetInput()
    #dataset <- data.frame(dataset) # can just use matrix
    dataset

  }, sanitize.text.function = function(x) x,
  include.colnames = FALSE, include.rownames = FALSE

  )

  # Create a reactiveValues object, to let us use settable reactive values
  values <- reactiveValues()
  values$clicked <- FALSE
  values$code <- NULL

  # When the app loads, if there is a hash value then load that figure
  observe({
    urlHash <- session$clientData$url_hash_initial
    if (!is.null(urlHash) && substring(urlHash, 1, 1) == "#") {
      values$code <- substring(urlHash, 2)
    }
  })

  # When a figure is clicked, load that figure
  observe({
    if (!is.null(input$clicked) && input$clicked == TRUE) {
      values$code <- input$code

      # Add figure name to URL so it can be retrieved later
      session$sendCustomMessage("figClick", values$code)
    }
  })

  # Load a figure and open the Figure tab
  observeEvent(values$code, {
    # get contents of figure R file
    r_file <- file.path('data', paste0(values$code, ".R"))

    x <- includeText(r_file)

    updateAceEditor(session, "fig_and_code",
                    mode="r", value = x)

    #   		updateAceEditor(session, "code_only",
    # 											mode="r", value = x)

    updateTabsetPanel(session, "tabset", selected = "Figure & Code")
  })

  output$figImage <- renderImage({

    if(length(values$code) == 0) {
      filename <- normalizePath(file.path('www',
                                          paste("please-select-figure.png")))
    } else {
      filename <- normalizePath(file.path('www/figures',
                                          paste0(values$code, ".png")))
    }
    list(src = filename,
         width = 600,
         height = 600)
  }, deleteFile = FALSE)

  output$figImage_only <- renderImage({

    if(length(values$code) == 0) {
      filename <- normalizePath(file.path('www',
                                          paste("please-select-figure.png")))
    } else {
      filename <- normalizePath(file.path('www/figures',
                                          paste0(values$code, ".png")))
    }
    list(src = filename,
         width = 600,
         height = 600)
  }, deleteFile = FALSE)

  output$code_only <- reactive({
    x <- "Please select a figure"
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

})

