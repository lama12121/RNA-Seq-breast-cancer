# Install required packages if not already installed
if (!require("data.table")) install.packages("data.table")
if (!require("R.utils")) install.packages("R.utils")
library(data.table)
library(R.utils)

# List of file URLs from GEO
urls <- c(
  "https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM8899nnn/GSM8899884/suppl/GSM8899884_MCF7_CTRLH1_counts.txt.gz",
  "https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM8899nnn/GSM8899885/suppl/GSM8899885_MCF7_CTRLH2_counts.txt.gz",
  "https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM8899nnn/GSM8899886/suppl/GSM8899886_MCF7_CTRLN1_counts.txt.gz",
  "https://ftp.ncbi.nlm.nih.gov/geo/samples/GSM8899nnn/GSM8899887/suppl/GSM8899887_MCF7_CTRLN2_counts.txt.gz"
)

# Appropriate sample names
sample_names <- c("CTRLH1", "CTRLH2", "CTRLN1", "CTRLN2")

# Temporary directory for downloads
dir.create("counts", showWarnings = FALSE)

# Download files and decompress them
for (i in seq_along(urls)) {
  destfile <- paste0("counts/", sample_names[i], ".txt.gz")
  download.file(urls[i], destfile)
  gunzip(destfile, remove=TRUE)
}

# Read files and merge them into a single matrix
counts_list <- list()
for (i in seq_along(sample_names)) {
  file_path <- paste0("counts/", sample_names[i], ".txt")
  
  # Select only relevant columns: first column = GeneID, seventh column = counts
  df <- fread(file_path, select = c(1, 7))
  
  # Rename columns
  colnames(df) <- c("GeneID", sample_names[i])
  
  counts_list[[i]] <- df
}

# Merge dataframes by GeneID
merged_counts <- Reduce(function(x, y) merge(x, y, by="GeneID", all=TRUE), counts_list)

# Replace missing values with 0
merged_counts[is.na(merged_counts)] <- 0

# Export the final expression matrix
fwrite(merged_counts, file="counts_matrix.csv")

# Create the sample information file
samples_info <- data.frame(
  Sample = sample_names,
  Condition = c("Hypoxia", "Hypoxia", "Normoxia", "Normoxia")
)
write.csv(samples_info, "samples_info.csv", row.names = FALSE)

cat("✅ Files downloaded and prepared successfully! \n📁 Files:\n - counts_matrix.csv\n - samples_info.csv\n")


