# Pipeline for Repositioning Anti-Cancer Drugs using Copy Number Variation Data
A Capstone Project for BYU BIO465

---

## About
This repository hosts the project files and report for the BYU bioinformatics capstone. 
It's purpose is to provide a flexible pipeline to perform drug repositioning using [GENIE](http://www.aacr.org/Newsroom/Pages/News-Release-Detail.aspx?ItemID=994#.WJ0EP61lBVQ) and [GDSC](http://www.cancerrxgene.org/) CNV data.
It was developed by Jared Nielson, Richard Olpin and Kaleb Olson.

Of primary interest is the [PipelineDevelopment.Rmd](PipelineDevelopment.Rmd) in which our pipeline which is written in a literate programming style.
Also of importance are the preprocessed `.rds` data files which allow you to avoid the cost of processing the data anew if you just want to play with the pipeline.

There are several exploratory `.Rmd` files that are here mainly for historical reasons.

## Dependencies
The pipline was written in R and depends on the following libraries:
ggplot2, viridis, dplyr, reshape2, magrittr, readr, synapseClient, tidyverse, and data.table

## Run the Pipeline
The recommended way to work with the pipeline is to simply load [PipelineDevelopment.Rmd](PipelineDevelopment.Rmd) in RStudio. 

## Acknowledgements
The insight and guidence of [Dr. Stephen R. Piccolo](http://piccolo.byu.edu/) has been invaluable and without which this project would not have been possible.
