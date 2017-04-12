
I assume you are looking at the "Gene level copy number data" file? Although not directly comparable to the GENIE CNV data, it should be relatively easy to merge these data sets. You'll need to look at the data definitions under the Legend worksheet to see how the values in GDSC translate to the GENIE CNV values. I can help with that, if needed. Notice that in this file the column names are cell line names (for example, "201T"). Ignore those. Instead use the identifiers on the second header row (for example, "1287381").

If you look in the "Annotated list of Cell lines" file, you will see information about each cell line, including these identifiers. They use the term "COSMIC identifier" to refer to these cell line identifiers.

Next look in the "log(IC50) and AUC values" file. You will see a column called "COSMIC_ID". Those identifiers should line up with the ones I mentioned above for the cell lines. You will also see a DRUG_ID column. That indicates what drug was applied to the respective cell lines. You can find information about the drugs in the "Screened Compounds" file.

Next look at the LN_IC50 column in that file. That indicates the drug response. Smaller values indicate a better response (only a small amount of drug was necessary to kill the cancer cell lines).

So your workflow would be first export everything to text files so you can parse them more easily with R or Python. Then search through the "log(IC50) and AUC values" file...for each drug, you would identify cell lines whose response was below a certain threshold (maybe -2). Those would be the "responders." Then you would retrieve CNV data from the  "Gene level copy number data" file and build a data matrix of CNV values that you would compare against GENIE.

Does that make sense?

By the way, because there is mutation data (in addition to CNV) in both databases, I would love to see you use both. It should give you much better results. But for now, focus on getting the pipeline to work with the CNV data only.

---

In looking through the CNV data from GDSC, they have highlighted any case where there is a 0 for either of the first two numbers. These are homozygous deletions and would be similar to the -2 cases in the GENIE data. They have also highlighted any case where there is an 8+ for the first two numbers. These are high-level amplifications and would be similar to the 2 cases in the GENIE data. I'm not sure why they selected 8 as a threshold. I think you would also look for cases where there is a "d" for the 4th value. You might need to look for more subtle situations, but you could start out with that
