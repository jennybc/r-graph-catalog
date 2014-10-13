##---- check hardcoded basenames ----

library(stringr) #str_trim

## 2014-10-12 Jenny: this path clearly makes an assumption about working dir
# get R files 
r_files <- list.files(file.path("..", "figures"), pattern = ".R", recursive = TRUE)

checklist <- data.frame(r_file = basename(r_files), 
                        bname_match = rep(NA, length(r_files)))

for(i in 1:length(r_files)) {
  
  fileConn <- file(file.path("..", "figures", r_files[i]))
  txt <- readLines(fileConn) 
  close(fileConn)
  
  # get index of line containing this_base
  ind <- grep("this_base <- ", txt)
  
  # extract file name 
  tmp <- sub("this_base <- *", "\\1", txt[ind])
  tmp <- gsub('\"', "", tmp)
  tmp <- str_trim(tmp) # remove trailing whitespace
  
  if(tmp == sub(".R", "", basename(r_files[i]))) {
    
    checklist$bname_match[[i]] <- TRUE
    
  } else {
    
    checklist$bname_match[[i]] <- FALSE
    
  }
  
}

message(paste(sum(checklist$bname_match), "out of", nrow(checklist), 
              "hardcoded basenames matches the figure directory name."))


