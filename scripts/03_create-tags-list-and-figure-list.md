

```r
library(plyr)

## Generate figures list and corresponding tags list

# get list of fig directories
basenames <- list.files(file.path(PROJHOME, "figures"))

# get tags files
fig_tags_files <- list.files(file.path(PROJHOME, "figures", basenames),
                             pattern = "_tags.txt$", full.names = TRUE)

names(fig_tags_files) <- basenames

fig_tags <- ldply(fig_tags_files, readLines)
fig_tags <- rename(fig_tags, c(".id" = "basename", "V1" = "tags"))

# remove figures that we arent doing from the figure list
fig_tags <- fig_tags[grep("not doing", fig_tags$tags, invert = TRUE), ]

## Generate tags list

all_tags <- unique(unlist(strsplit(fig_tags$tags, split = ",")))

# chapter tags
tags_chap <-
  grep(paste0("ch", "[[:digit:]][[:digit:]]", "_"), all_tags, value = TRUE)

# type tags
to_match <- c("good", "bad", "not recommended")
tags_type <- 
  unique(grep(paste(to_match, collapse = "|"), all_tags, value = TRUE))

to_match_graph_elem <- c("annotation", "footnote", "multiple plots",
                         "data labels", "loess smoothing", "jitter",
                         "legend", "subscript")

tags_graph_elem <- unique(grep(paste(to_match_graph_elem, collapse = "|"),
                               all_tags, value = TRUE))

# chart type tags
tags_other <-
  setdiff(all_tags, c("naomi", tags_chap, tags_type, tags_graph_elem))

tags_only <-
  data.frame(c("===GRAPH TYPE===", sort(tags_type), "===GRAPH TAGS===",
               sort(tags_other), "===GRAPH ELEMENTS===", sort(tags_graph_elem),
               "===CHAPTER===", sort(tags_chap)))

names(tags_only) <- "List of all tags"

tags_only
```

```
##             List of all tags
## 1           ===GRAPH TYPE===
## 2                       good
## 3            not recommended
## 4           ===GRAPH TAGS===
## 5                  area plot
## 6                  bar chart
## 7                    boxplot
## 8               bubble chart
## 9                   dot plot
## 10          ggplot2_tutorial
## 11                   heatmap
## 12                 histogram
## 13                line graph
## 14                month plot
## 15               mosaic plot
## 16                     other
## 17 parallel coordinates plot
## 18                 pie chart
## 19                 rose plot
## 20               scatterplot
## 21              spline graph
## 22                 stripplot
## 23                     table
## 24                    themes
## 25                timeseries
## 26              transparency
## 27           trellis display
## 28              waffle chart
## 29      ===GRAPH ELEMENTS===
## 30                annotation
## 31               data labels
## 32                  footnote
## 33                    jitter
## 34                    legend
## 35           loess smoothing
## 36            multiple plots
## 37                 subscript
## 38             ===CHAPTER===
## 39                ch01_intro
## 40          ch02_limitations
## 41           ch03_perception
## 42              ch04_1or2dim
## 43         ch05_morethan2var
## 44              ch06_general
## 45               ch07_scales
## 46          ch08_beforeafter
## 47             ch09_software
## 48                ch10_qanda
```

```r
head(fig_tags)
```

```
##                                                      basename
## 1                       0002_add-background-with-cats-package
## 2                              0003_xkcd-and-direct-labelling
## 3                              0004_scatterplot-nothing-fancy
## 4                              0005_scatterplot-log-transform
## 5                    0006_scatterplot-map-continent-to-colour
## 6 0007_scatterplot-overplotting-fix-set-transparency-and-size
##                                                tags
## 1                            other,scatterplot,good
## 2 other,line graph,good,data labels,loess smoothing
## 3                 scatterplot,good,ggplot2_tutorial
## 4                 scatterplot,good,ggplot2_tutorial
## 5                 scatterplot,good,ggplot2_tutorial
## 6                 scatterplot,good,ggplot2_tutorial
```

```r
out_dir <- file.path(PROJHOME, "r-graph-catalog", "data")
if(!file.exists(out_dir)) {
	dir.create(out_dir)
}

## sort figure basenames so CMEG figs come first (at least for now)
fig_tags <- mutate(fig_tags, CMEG = grepl("^fig", basename))
fig_tags <- fig_tags[order(desc(fig_tags$CMEG), fig_tags$basename), ]

## Save to file
write.table(tags_only,
            file.path(PROJHOME, "outputs", "available-tags.tsv"),
            sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)

write.table(fig_tags,
            file.path(out_dir, "figure-list.tsv"),
            sep = '\t', row.names = FALSE, quote = FALSE)
```


---
title: "03_create-tags-list-and-figure-list.R"
author: "joannazhao"
date: "Wed Feb 25 18:04:25 2015"
---
