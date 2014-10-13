#---- Check directories

# Check if there are directories NOT created automatically existing
# below "figures/"

fig_dirs_found <-
	data.frame(fig_dir = I(list.files(file.path(PROJHOME, "figures"))))

fig_tags <- list.files(file.path(PROJHOME, "figures", fig_dirs_found$fig_dir),
														 pattern = "_tags.txt$", full.names = TRUE)

# get tags for each figure 
for(i in 1:length(fig_tags)) {
	fig_dirs_found$tags[i] <- readLines(fig_tags[i]) 	
}

fig_dirs_found$official <- grepl("naomi", fig_dirs_found$tags)
table(fig_dirs_found$official)	

if(any(!fig_dirs_found$official)) {
  message("Directories found in 'figures/' that are not programmatically created: ")
  with(fig_dirs_found, fig_dir[!official])
} else {
  message("Confirmed: all directories in 'figures/' are managed programmatically.")
}




