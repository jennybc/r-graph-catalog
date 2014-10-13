library(plyr) #ldply()
library(stringr)

initFigureDirectory <- function(x) {
  
  if(x == "") {
    
    stop("Please enter a name for your figure!")
    
  } else {
    
    #---- Set up 
    fig_dirs <- list.files(file.path(PROJHOME, "figures"))
    
    #---- Get next number for naming new figure directory
    
    # find fig dirs that start with digit
    ind <- grepl("^[0-9]+", fig_dirs)
    
    # find figures not in Naomi 
    if(any(ind)) {
      
      list_of_figs <- fig_dirs[ind]
      
      list_of_figs <- strsplit(list_of_figs, "_")
      
      df <- ldply(list_of_figs)
      
      colnames(df) <- c("number", "name")
      df$number <- as.numeric(df$number)
      
      new_number <- max(df$number) + 1
      new_number <- sprintf("%04d", new_number)	
      
    } else {
      
      new_number <- "0001"
      
    }
    
    # new fig directory name with number prepended
    FOLDER_NAME <- paste0(new_number, "_", x)
    
    #---- build path to new figure directory
    
    new_fig_dir <- file.path(PROJHOME, "figures", FOLDER_NAME)
    dir.create(new_fig_dir)
    
    #---- Fill new fig dir with skeleton elements
    
    files_to_create <- 
      file.path(file.path(PROJHOME, "figures", FOLDER_NAME), 
                c("README-fodder.md", paste0(FOLDER_NAME, "_tags.txt"),
                  paste0(FOLDER_NAME, ".R"), "instructions.md"))
    
    names(files_to_create) <- c("readme_fodder", "tags", "r_file", "instructions")
    
    readme_fodder_contents <- "Input any special figure description here."
    
    tags_contents <- paste0("other,scatterplot,good")
    
    # update figure number in example.R			
    txt <- readLines(file.path("inputs", "example.R"))
    
    new_txt <- gsub('this_base <- "0001_my-awesome-figure"', 
                    paste0('this_base <- "', FOLDER_NAME, '"'), txt)
    
    new_base <- gsub('title: "My Awesome Figure"', 
                     paste0('title: ', toupper(gsub("-", " ", x))), new_txt)
    
    writeLines(new_base, files_to_create["r_file"])
    
    # create README-fodder.md, tags file, and instructions.md
    
    writeLines(readme_fodder_contents, files_to_create["readme_fodder"])
    
    writeLines(tags_contents, files_to_create["tags"])
    
    file.copy(file.path("inputs", "instructions.md"), 
              files_to_create["instructions"])
    
    if(all(file.exists(files_to_create))) {
      message(paste(new_fig_dir , "successfully created!\n",
                    "4 files created in figure directory:\n",
                    basename(files_to_create["r_file"]), "\n",
                    basename(files_to_create["tags"]), "\n",
                    basename(files_to_create["readme_fodder"]), "\n",
                    basename(files_to_create["instructions"])))
      
    } else {
      ind <- which(file.exists(files_to_create) == FALSE)
      message(paste(files_to_create[ind], "failed,"))
    }
    
  }
  
}

#---- Take in arg from R console 

# arg <- readline(paste("What would you like to call your figure?",
#                       "(ie. my-awesome-figure)\n"))

#---- Take in arg from command line 

cat(paste("What would you like to call your figure?",
          "(ie. my-awesome-figure)\n"))

arg <- readLines(file("stdin"), 1)

initFigureDirectory(arg)

