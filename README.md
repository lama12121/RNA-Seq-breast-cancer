
# Breast Cancer RNA-Seq Differential Expression Analysis using DESeq2 in R

This project performs differential gene expression analysis on breast cancer RNA-Seq count data using the DESeq2 package in R. It includes data preprocessing, statistical testing, visualization of results, and identification of significant genes associated with experimental conditions.

## Project Overview

- Download and preprocess RNA-Seq count data from GEO.
- Merge and clean count matrices.
- Perform differential expression analysis comparing Hypoxia vs. Normoxia conditions.
- Visualize results with Volcano plot, PCA plot, and Heatmap of top differentially expressed genes.
- Export differential expression results for further analysis.

## Technologies & Packages

- R (version >= 4.0)
- Bioconductor package: DESeq2
- ggplot2 for plotting
- pheatmap for heatmap visualization
- data.table and R.utils for efficient data handling
- quantmod for data retrieval (optional)

## File Structure

- `counts_matrix.csv`: Processed gene expression count matrix.
- `samples_info.csv`: Metadata describing sample conditions.
- `DEG_results.csv`: Differential expression analysis results exported from DESeq2.
- `LSTM_stock_prediction.R`: (If applicable, otherwise remove this line)
- `README.md`: Project documentation.
- `Plots`: Include Visualization results

## Usage Instructions

1. **Setup environment**

   Install required R packages if not already installed:

   ```r
   install.packages(c("ggplot2", "pheatmap", "data.table", "R.utils"))
   if (!requireNamespace("BiocManager", quietly = TRUE))
       install.packages("BiocManager")
   BiocManager::install("DESeq2")
Run data preprocessing script

2. Download and prepare raw count files from GEO, merge, and create sample metadata.

3. Run DESeq2 analysis

 Use the provided R script to load the count matrix and sample information, create the DESeqDataSet, run differential expression analysis, and generate plots.

4. Explore results

Check DEG_results.csv for gene-level differential expression statistics.

Visualizations
-Volcano plot: Highlights genes with significant fold changes and adjusted p-values.

PCA plot: Visualizes sample clustering based on gene expression profiles.

-Heatmap: Displays expression patterns of the top 20 most significant genes across samples.

References
-DESeq2 Bioconductor: https://bioconductor.org/packages/release/bioc/html/DESeq2.html

-GEO database: https://www.ncbi.nlm.nih.gov/geo/

-RNA-Seq data analysis tutorials and documentation.
