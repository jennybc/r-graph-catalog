## get top-level directory for this project
proj_dir <-
  normalizePath(if(basename(getwd()) == "cmeg") file.path("..", "..") else getwd())

app <-
  read.delim(file.path(proj_dir,
                       "inputs", "appendix-b.tsv"), colClasses = "character")

# --- format figure numbers
library(reshape2) # colsplit()
df <- app[c('Figure.Number', 'Title')]
df <- data.frame(df, colsplit(df$Figure.Number, pattern = "\\.",
                              names = c("left", "right")))

# pad left and right side of "." to two digits
df$fig_no <-
  with(df, paste0("fig", sprintf("%02d", left), "-", sprintf("%02d", right)))

# ---- format figure titles
df$titles <- tolower(df$Title)

# replace all punctuation characters and spaces with a '-'
df$titles <- gsub("[[:punct:]]", "-", df$titles)
df$titles <- gsub(" ", "-", df$titles)

df$titles <- gsub("-$", "", df$titles) # remove trailing '-'
df$titles <- gsub("--|---", "-", df$titles) # replace repeated '-'

# ---- put figure number and title together
df$basename <- with(df, paste(fig_no, titles, sep = "_"))

# ---- merge back into Appendix B
foo <- merge(app, df[c('Figure.Number', 'Title', 'basename')])

# ---- put into the row order everyone expects
foo <- foo[order(foo$basename), ]

# ---- create outputs directory if does not exist
out_dir <- file.path(proj_dir, "outputs")
if(!file.exists(out_dir)) {
  dir.create(out_dir)
}

write.table(foo,
            file.path(out_dir, "appendix-b-with-basenames.tsv"),
            quote = FALSE, sep = "\t", row.names = FALSE)
