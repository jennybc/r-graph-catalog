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

head(fig_tags)

# ---- create outputs directory if does not exist
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
