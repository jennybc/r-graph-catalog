#' ---
#' title: ADD BACKGROUND WITH CATS PACKAGE
#' ---

library(ggplot2)

this_base <- "0002_add-background-with-cats-package"

## devtools::install_github("hilaryparker/cats")
library(cats)
## library(help = "cats")

p <- ggplot(mpg, aes(cty, hwy)) +
  add_cat() +
  geom_point()
p

ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)
