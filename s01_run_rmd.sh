#!/bin/bash

# run_rmd.sh
# Run Rmd file in batch mode on Darwin cluster
# Started: Alexey Larionov, 09Mar2017
# Last updated: Alexey Larionov, 03Apr2017

# Use: run_rmd.sh script.Rmd
/usr/lib/R/bin/exec/R --slave --no-slave --no-restore -e "rmarkdown::render(${1})" &> log1.txt
 
