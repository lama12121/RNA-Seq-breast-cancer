# Step 1: Load libraries
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
#BiocManager::install("DESeq2")
install.packages("ggplot2")
install.packages("pheatmap")

library(DESeq2)
library(ggplot2)
library(pheatmap)

# Step 2: Read data
counts <- read.csv("~/breast cancer/counts_matrix.csv", row.names = 1)
samples <- read.csv("~/breast cancer/samples_info.csv", row.names = 1)

# Check if column names and row names match
all(colnames(counts) == rownames(samples))  # Should return TRUE

# Step 3: Create DESeqDataSet object
# Convert column to factor to avoid warnings
samples$Condition <- as.factor(samples$Condition)

dds <- DESeqDataSetFromMatrix(countData = counts,
                              colData = samples,
                              design = ~Condition)

# Step 4: Perform differential expression analysis
dds <- DESeq(dds)
res <- results(dds)

# Show top 6 significant genes
head(res[order(res$padj), ])

# Save results to file
write.csv(as.data.frame(res), file = "DEG_results.csv")

# Step 5: Plot Volcano Plot
res$significant <- ifelse(res$padj < 0.5 & abs(res$log2FoldChange) > 1, "Yes", "No")

ggplot(as.data.frame(res), aes(x = log2FoldChange, y = -log10(padj), color = significant)) +
  geom_point(alpha = 0.8) +
  theme_minimal() +
  labs(title = "Volcano Plot", x = "Log2 Fold Change", y = "-Log10 Adjusted P-value") +
  scale_color_manual(values = c("grey", "red"))

# Step 6: Plot PCA
vsd <- vst(dds, blind = FALSE)
plotPCA(vsd, intgroup = "Condition")

# Step 7: Plot Heatmap of top differentially expressed genes
topGenes <- head(order(res$padj), 20)
mat <- assay(vsd)[topGenes, ]
pheatmap(mat, scale = "row", cluster_rows = TRUE, cluster_cols = FALSE)




