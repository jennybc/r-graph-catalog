

```r
library(plyr)

## get top-level directory for this project
proj_dir <-
  normalizePath(if(basename(getwd()) == "scripts") ".." else getwd())

## Generate figures list and corresponding tags list

# get list of fig directories
basenames <- list.files(file.path(proj_dir, "figures"))

# get tags files
fig_tags_files <- list.files(file.path(proj_dir, "figures", basenames),
                             pattern = "_tags.txt$", full.names = TRUE)

names(fig_tags_files) <- basenames

fig_tags <- ldply(as.list(fig_tags_files), function(x) {
  tags_pre <- scan(x, character(), sep = ",", quiet = TRUE)
  tags_post <- paste(tags_pre, collapse=",")
  data.frame(tags = I(tags_post))
})

fig_tags <- rename(fig_tags, c(".id" = "basename"))

# remove figures that we arent doing from the figure list
fig_tags <- fig_tags[-grep("not doing", fig_tags$tags),]


## Generate tags list

all_tags <- unique(unlist(strsplit(fig_tags$tags, split = ",")))

# chapter tags
ind_chap <- grep(paste0("ch", "[[:digit:]][[:digit:]]", "_"), all_tags)
tags_chap <- all_tags[ind_chap]

# type tags
to_match <- c("good", "bad", "not recommended")
ind_type <- unique(grep(paste(to_match, collapse = "|"), all_tags))
tags_type <- all_tags[ind_type]


to_match_graph_elem <- c("annotation", "footnote", "multiple plots",
                         "data labels", "loess smoothing", "jitter",
                         "legend", "subscript")

ind_graph_elem <- unique(grep(paste(to_match_graph_elem, collapse = "|"), all_tags))
tags_graph_elem <- all_tags[ind_graph_elem]

# chart type tags
tags_other <- all_tags[-c(ind_chap, ind_type, ind_graph_elem)]

tags_other <- tags_other[-which(tags_other == "naomi")]

tags_only <- data.frame(c("===GRAPH TYPE===", tags_type, "===GRAPH TAGS===",
                          tags_other, "===GRAPH ELEMENTS===", tags_graph_elem,
                          "===CHAPTER===", tags_chap))

names(tags_only) <- "List of all tags"

tags_only
```

```
##             List of all tags
## 1           ===GRAPH TYPE===
## 2            not recommended
## 3                       good
## 4           ===GRAPH TAGS===
## 5                  pie chart
## 6                   dot plot
## 7                      table
## 8                  bar chart
## 9                 line graph
## 10              bubble chart
## 11               scatterplot
## 12                 stripplot
## 13                 histogram
## 14                   boxplot
## 15                timeseries
## 16                month plot
## 17           trellis display
## 18              spline graph
## 19               mosaic plot
## 20 parallel coordinates plot
## 21                 rose plot
## 22                 area plot
## 23              waffle chart
## 24      ===GRAPH ELEMENTS===
## 25                    legend
## 26                annotation
## 27            multiple plots
## 28                    jitter
## 29           loess smoothing
## 30               data labels
## 31                 subscript
## 32                  footnote
## 33             ===CHAPTER===
## 34                ch01_intro
## 35          ch02_limitations
## 36           ch03_perception
## 37              ch04_1or2dim
## 38         ch05_morethan2var
## 39              ch06_general
## 40               ch07_scales
## 41          ch08_beforeafter
## 42             ch09_software
## 43                ch10_qanda
```

```r
head(fig_tags)
```

```
##                                                        basename
## 1                                   fig01-01_similar-pie-wedges
## 2                          fig01-02_similar-pie-wedges-dot-plot
## 3                             fig01-03_similar-pie-wedges-table
## 4                                  fig02-01_structured-data-set
## 5                         fig02-02_structured-data-set-dot-plot
## 7 fig02-04_three-dimensional-pie-data-two-dimensional-bar-chart
##                                               tags
## 1       pie chart,ch01_intro,naomi,not recommended
## 2                   dot plot,good,ch01_intro,naomi
## 3                      table,good,ch01_intro,naomi
## 4 pie chart,ch02_limitations,naomi,not recommended
## 5             dot plot,good,ch02_limitations,naomi
## 7            bar chart,good,ch02_limitations,naomi
```

```r
out_dir <- file.path(proj_dir, "r-graph-catalog", "data")
if(!file.exists(out_dir)) {
	dir.create(out_dir)
}

## Save to file

write.table(tags_only,
            file.path(proj_dir, "outputs", "available-tags.tsv"),
            sep = '\t', row.names = FALSE, col.names = FALSE, quote = FALSE)

write.table(fig_tags,
            file.path(out_dir, "figure-list.tsv"),
            sep = '\t', row.names = FALSE, quote = FALSE)
```


---
title: "03_create-tags-list-and-figure-list.R"
author: "jzhao"
date: "Wed Oct  8 16:25:33 2014"
---
