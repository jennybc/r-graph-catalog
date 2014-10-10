R Graph Catalog
===============

The [r-graph-catalog](r-graph-catalog) subdirectory of this repo creates the [R Graph Catalog](http://shinyapps.stat.ubc.ca/r-graph-catalog/) Shiny app.

This catalog is a complement to ["Creating More Effective Graphs"](http://www.amazon.com/Creating-Effective-Graphs-Naomi-Robbins/dp/0985911123) by [Naomi Robbins](http://www.nbr-graphs.com). All graphs were produced using the [`R` language](http://www.r-project.org) and the add-on package [`ggplot2`](http://ggplot2.org), written by [Hadley Wickham](http://hadley.github.io). The gallery is maintained by Joanna Zhao and [Jennifer Bryan](http://www.stat.ubc.ca/~jenny/).

The initial work on this project was facilitated by an [NSERC Undergraduate Student Research Award](http://www.nserc-crsng.gc.ca/students-etudiants/ug-pc/usra-brpc_eng.asp).

#### Inspiration

We are inspired by the [R graph gallery](http://rgraphgallery.blogspot.ca) and [rCharts Gallery](http://rcharts.io/gallery/). Our goal is to create a simple and organized visual index of diverse ggplot2 graphs. Naomi Robbins' book provided a great set of figures to start with.

We are very interested in extending this catalog, possibly helping to revive to the dormant [R graph gallery](http://rgraphgallery.blogspot.ca).

#### Useful Resources

["Creating More Effective Graphs"](http://www.amazon.com/Creating-Effective-Graphs-Naomi-Robbins/dp/0985911123) by [Naomi Robbins](http://www.nbr-graphs.com)

[`ggplot2`](http://ggplot2.org) written by [Hadley Wickham](http://hadley.github.io)

[Winston Chang's](https://github.com/wch) book ["R Graphics Cookbook"](http://shop.oreilly.com/product/0636920023135.do) and the [Graphs section](http://www.cookbook-r.com/Graphs/) of his [Cookbook for R website](http://www.cookbook-r.com/)

[`ggplot2` tutorial](https://github.com/jennybc/ggplot2-tutorial) from May 2014, Vancouver R Users Group

[ggplot2 Version of Figures in "Lattice: Multivariate Data Visualization with R"](http://learnr.wordpress.com/2009/08/26/ggplot2-version-of-figures-in-lattice-multivariate-data-visualization-with-r-final-part/)

#### Contributing a figure

*Ideally, this would be easier, but let's just see if anyone wants to contribute a figure before we worry about this too much!*

1. Fork this repository and pull to your local machine.
2. Run `make init` to create your own figure directory under `figures`
3. In the newly generated figure directory, read `instuctions.md` and make the appropriate changes.
4. Make a single commit (include `*.R`, `*_tags.txt`, `README-fodder.md`, and data file (if any))
5. Push back to your fork on GitHub.
6. Make a pull request.
