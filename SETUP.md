# setup python venv
```virtualenv -p python3 venv```

# Set up data R to access data from synapse
Use this: http://docs.synapse.org/articles/getting_started.html
```{r} 
source("http://depot.sagebase.org/CRAN.R")
pkgInstall(c("synapseClient"))
```

# Get the data
R client doesn't recursively download so here are the synapse IDs:
```
CNA		      	    syn7851245
clinical	      	syn7851246
fusions		    	  syn7851249
guide		        	syn7851703
mutation_extended	syn7851250
combined.bed		  syn7851252
cna_hg19.seg	  	syn7851253
```

E.g., to get the CNA data and plot it:
```
cnafile <- synGet('syn7851253')
read_tsv(cnafile@filePath)
cna %>% arrange(CHROM) %>% ggplot(cna, aes(x=CHROM)) + geom_bar()
```

