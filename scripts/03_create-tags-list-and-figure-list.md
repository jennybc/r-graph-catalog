

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
## 10                 histogram
## 11                line graph
## 12                month plot
## 13               mosaic plot
## 14                     other
## 15 parallel coordinates plot
## 16                 pie chart
## 17                 rose plot
## 18               scatterplot
## 19              spline graph
## 20                 stripplot
## 21                     table
## 22                timeseries
## 23           trellis display
## 24              waffle chart
## 25      ===GRAPH ELEMENTS===
## 26                annotation
## 27               data labels
## 28                  footnote
## 29                    jitter
## 30                    legend
## 31           loess smoothing
## 32            multiple plots
## 33                 subscript
## 34             ===CHAPTER===
## 35                ch01_intro
## 36          ch02_limitations
## 37           ch03_perception
## 38              ch04_1or2dim
## 39         ch05_morethan2var
## 40              ch06_general
## 41               ch07_scales
## 42          ch08_beforeafter
## 43             ch09_software
## 44                ch10_qanda
```

```r
head(fig_tags)
```

```
##                                basename
## 1 0002_add-background-with-cats-package
## 2        0003_xkcd-and-direct-labelling
## 3           fig01-01_similar-pie-wedges
## 4  fig01-02_similar-pie-wedges-dot-plot
## 5     fig01-03_similar-pie-wedges-table
## 6          fig02-01_structured-data-set
##                                                tags
## 1                            other,scatterplot,good
## 2 other,line graph,good,data labels,loess smoothing
## 3        pie chart,ch01_intro,naomi,not recommended
## 4                    dot plot,good,ch01_intro,naomi
## 5                       table,good,ch01_intro,naomi
## 6  pie chart,ch02_limitations,naomi,not recommended
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
author: "jzhao"
date: "Wed Nov  5 13:41:54 2014"
---
