# #' ---
# #' title: XKCD AND DIRECT LABELLING
# #' ---
# 
# library(ggplot2)
# library(xkcd)
# 
# this_base <- "0003_xkcd-and-direct-labelling"
# 
# ## use an excerpt of the Gapminder data
# ## prepared and posted by Jenny Bryan for use in teaching
# gd_url <- "http://tiny.cc/gapminder"
# gdf <- read.delim(file = gd_url)
# str(gdf)
# 
# my_countries <- c("Canada", "Rwanda", "Oman")
# hdf <- droplevels(subset(gdf, country %in% my_countries))
# 
# direct_label <- data.frame(year = 2009,
#                            lifeExp = hdf$lifeExp[hdf$year == 2007],
#                            country = hdf$country[hdf$year == 2007])
# 
# xrange <- c(1952, 2010)
# yrange <- c(20, 83)
# set.seed(123)
# 
# p <- ggplot() +
#   geom_smooth(data = hdf,
#               aes(x = year, y = lifeExp, group = country, linetype = country),
#               se = FALSE, color = "black") +
#   theme(legend.position = "none") + 
#   xkcdaxis(xrange, yrange) +
#   geom_text(aes(x = year + 1.5, y = lifeExp + 3, label = country), data = direct_label,
#             hjust = 1, vjust = 1,family = "xkcd", size = 7)  
# 
# ## we do not print the plot because that triggers creation of an unnecessary
# ## PDF, which causes an error due to missing fonts (the xkcd packages uses a
# ## special font); printing to PNG does work
# 
# ## uncomment this for interactive use
# #p
# 
# ggsave(paste0(this_base, ".png"), p, width = 6, height = 5)
