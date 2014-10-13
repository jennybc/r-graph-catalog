#---- Read Appendix B + figure file and directory basenames

app <-
  read.delim(file.path(PROJHOME, "outputs", "appendix-b-with-basenames.tsv"),
             stringsAsFactors = FALSE,
             colClasses = list(Figure.Number = "character"))
str(app)


#---- Create figure directories

app$exists <- 
  with(app, file.exists(file.path(PROJHOME, "figures", basename)))
table(app$exists)	

if(any(!app$exists)) {
  make_this_dir <- which(!app$exists)
  make_this_dir <-
    with(app, file.path(PROJHOME, "figures", basename[make_this_dir]))
  dir_make_result <- sapply(make_this_dir, dir.create)
  message("Directories created in 'figures/':")
  basename(names(dir_make_result)[dir_make_result])
  if(any(!dir_make_result)) {
    message("Unsuccessful attempt to create these directories in 'figures/':")
    basename(names(dir_make_result)[!dir_make_result])
  }
} else {
  message("All figure directories already exist.")
}

app$exists <- 
  with(app, file.exists(file.path(PROJHOME, "figures", basename)))
table(app$exists)	

