#!/bin/bash

# run_rmd.sh
# Run Rmd file in batch mode on Darwin cluster
# Started: Alexey Larionov, 09Mar2017
# Last updated: Alexey Larionov, 09Mar2017

# Use: run_rmd.sh script.Rmd
# Note: the script must end by .Rmd  

# Compile R expressions to run (commnds are in single line, separated by semicolon)
r_expressions="library('rmarkdown'); render('"${r_script}"')"

# Run R expressions
"${r}" -e "${r_expressions}"
