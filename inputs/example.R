#' ---
#' title: "My Awesome Figure"
#' ---

library(ggplot2)

this_base <- "0001_my-awesome-figure"

# ---- REPLACE THE CODE BELOW WITH YOUR OWN ---- 
# NOTE: Write your ggplot object as p and use ggsave() to save your figure:
#       eg: ggsave(paste0(this_base, ".png")), p, width, height)

p <- ggplot(mtcars, aes(x = mpg, y = disp)) +
geom_point() +
labs(x = "Miles per gallon", y = "Displacement (cu.in.)")

p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)
