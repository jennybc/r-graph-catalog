How to prepare your figure directory for the R Graph Catalog

1. In `*.R`
	- in the yaml header, change the title of your figure if necessary (this title will appear in the `README.md` for this figure directory)
	- paste your figure making code in the appropriate section
	- source your R code to make sure the figure displays as desired
	- if your figure uses data from a data file, make sure to include the data file in the figure directory

2. In `*_tags.txt`,
	- insert appropriate tags (comma delimited) for your figure, for a list of available tags, please take a look at `available-tags.tsv` in the outputs folder

4. In `README-fodder.md`, input a figure description.

5. Make a commit. (include `*.R`, `*_tags.txt`, `README-fodder.md`, and `*.tsv`/`*.csv`/`*.txt` (if any))

6. Push to the branch.

7. Make a new pull request.
