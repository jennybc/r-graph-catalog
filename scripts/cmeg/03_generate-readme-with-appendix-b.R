arg <- commandArgs(trailingOnly = TRUE) 

generateReadmeForCMEG <- function(x) { 
  
  bname <- basename(x)
  
  ## return to top level directory
  proj_dir <- file.path("..", "..") 
  
  app <-
    read.delim(file.path(proj_dir, "outputs", "appendix-b-with-basenames.tsv"),
               stringsAsFactors = FALSE)
  
  ind <- grep(bname, app$basename)
  app <- app[ind,]
  
  readme <- paste0("##Figure ", app$Figure.Number, " ", app$Title, "\n\n",
                   "####Page: ", app$Page, "\n",
                   "####Data Availability Status: ", app$Data.Availability, 
                   "\n***\n", "![`", app$Title, "`](", bname, ".png)")
  
  fileConn <- file("README.md")
  
  readme_fodder_file <- "README-fodder.md"
  
  if(file.exists(readme_fodder_file)) {
    
    # append README-fodder to end of auto README
    readme_string <- paste(readLines(readme_fodder_file), collapse="\n")
    contents <- paste(readme , readme_string, sep = "\n\n")    
    
  } else {
    
    contents <- readme
    
  }
  
  writeLines(contents, fileConn)
  
  close_ret_val <- close(fileConn)  # close connection
  
  if(close_ret_val == 0) {
    
    message("README.md successfully updated")
  
  }

}

generateReadmeForCMEG(arg)
