# eg. arg <- 'figures/fig08-14_population-data-by-race'

arg <- commandArgs(trailingOnly = TRUE) 

library(methods)

# set "null" device so that Rplots.pdf is not created when calling 
# ggsave() using Rscript
options(device = function(...) {
	pdf(file = NULL)
})

processFigureDirectory <- function(x) {
	
	## 2014-10-12 Jenny: this path specification doesn't look very robust to me
	# generate README.md
	system(paste('Rscript ./scripts/02_generate-readme.R', 
	             file.path(arg)))
	
	
	# generate figure PNG from .R file
  print(file.path(PROJHOME, x, paste0(basename(x), ".R")))
  
	source(file.path(PROJHOME, x, paste0(basename(x), ".R")))
  
	if(file.exists(file.path(PROJHOME, x, paste0(basename(x), ".png")))) 
		message(paste0(basename(x), ".png successfully created"))
	
	# generate figure thumbnail PNG 
	
	system(paste('Rscript ./scripts/01_create-thumbnail.R', 
							 file.path(arg, paste0(basename(arg), '.png'))))
	
}

processFigureDirectory(arg)

