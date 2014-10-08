arg <- commandArgs(trailingOnly = TRUE) 

generateReadme <- function(x) {
  # Create a general README.md that appends README-fodder.md if it 
  # exists and embed figure png.
  #
  # Args:
  #   x: file path to figure directory ; ie. "figures/0001_my-awesome-figure"
  # Returns:
  #   README.md created in figure directory.
  
  bname <- basename(x)
  
  r_file <- paste0(bname, ".R")
  
  # Find any yaml
  if(file.exists(r_file)) {
    
    # Read in R code
    txt <- readLines(r_file)
    
    if(any(grepl("#'", txt))) {
      
      ind <- grep("#' title:", txt) # indices of yaml
      
      title <- gsub("#' title: ", "", txt[ind])
      
    } else {
      
      title <- bname
      
    }
    
  } else {
    
    title <- bname
    
  }
  
  # contents of each README.md
  readme <- 
    paste0("##Figure: ", title, "\n***\n", "![`", bname, "`](", bname, ".png)")
  
  readme_fodder_file <- "README-fodder.md"
  
  if(file.exists(readme_fodder_file)) {
    
    # append README-fodder to end of auto README
    readme_string <- paste(readLines(readme_fodder_file), collapse="\n")
    contents <- paste(readme , readme_string, sep = "\n\n")    
    
  } else {
    
    contents <- readme
    
  }
  
  # establish connection to README.md, create if doesnt exist
  readme_file <- "README.md"
  
  fileConn <- file(readme_file)
  writeLines(contents, fileConn)
  
  close_ret_val <- close(fileConn)  # close connection
  
  if(close_ret_val == 0)
    
    message("README.md successfully created")
  
  
  
}

generateReadme(arg)
