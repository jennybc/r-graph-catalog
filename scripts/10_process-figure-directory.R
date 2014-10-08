# eg. arg <- 'figures/fig08-14_population-data-by-race'

arg <- commandArgs(trailingOnly = TRUE) 

library(methods)

# set "null" device so that Rplots.pdf is not created when calling 
# ggsave() using Rscript
options(device = function(...) {
	pdf(file = NULL)
})

processFigureDirectory <- function(x) {
	
	## get top-level directory for this project
	proj_dir <-
		normalizePath(if(basename(getwd()) == "scripts") ".." else getwd())
	
	# generate README.md
	system(paste('Rscript ./scripts/02_generate-readme.R', 
	             file.path(arg)))
	
	
	# generate figure PNG from .R file
  print(file.path(proj_dir, x, paste0(basename(x), ".R")))
  
	source(file.path(proj_dir, x, paste0(basename(x), ".R")))
  
	if(file.exists(file.path(proj_dir, x, paste0(basename(x), ".png")))) 
		message(paste0(basename(x), ".png successfully created"))
	
	# generate figure thumbnail PNG 
	
	system(paste('Rscript ./scripts/01_create-thumbnail.R', 
							 file.path(arg, paste0(basename(arg), '.png'))))
	
}

processFigureDirectory(arg)

