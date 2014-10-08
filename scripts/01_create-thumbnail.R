# eg. arg <-
# 'figures/fig08-14_population-data-by-race/fig08-14_population-data-by-race.png'

arg <- commandArgs(trailingOnly = TRUE)

makeThumb <- function(file) {
  library(png)

  # set image representation to native raster, reduces file size to draw
  img <- readPNG(file, native = TRUE)

  #attributes(img)

  img_height <- dim(img)[1]
  img_width <- dim(img)[2]

  new_img_height <- 250

  new_img_width <- new_img_height * (img_width / img_height)

  # 	# for testing
  # 	bname <- basename(file)
  # 	new_bname <- gsub(".png", "_thumb.png", bname)
  # 	new_filename <- file.path("r-graph-catalog", "www", "thumbnails", new_bname)

  new_filename <- gsub(".png", "_thumb.png", file)

  # open png device for new image
  png(file = paste(new_filename), height = new_img_height,
      width = new_img_width)

  par(mar = c(0, 0, 0, 0), xaxs = "i", yaxs = "i", ann = FALSE)

  plot(1:2, type = 'n', xaxt = "n", yaxt = "n", xlab = "", ylab = "")
  lim <- par()
  rasterImage(img, lim$usr[1], lim$usr[3], lim$usr[2], lim$usr[4])

  x <- dev.off()

  if(x == 1) {
    message(paste(basename(new_filename), "successfully created"))
  }

}

makeThumb(arg)
