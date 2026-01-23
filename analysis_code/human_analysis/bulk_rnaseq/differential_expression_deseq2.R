#!/usr/bin/env Rscript

library(tidyverse)       # ggplot2, dplyr, tibble 
library(DESeq2)
library(msigdbr)
library(org.Hs.eg.db)    # v3.16.0
library(AnnotationDbi)
library(glue)
library(reactome.db)     # v1.58.0
library(ReactomePA)
library(enrichplot)
library(readr)


fc_file <- "./humanDMD/2nd_DMD/counts_s2/gene_counts.matrix.txt"
out_dir <- "./humanDMD/2nd_DMD/DE_ifna_results"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

raw <- read.delim(fc_file, check.names = FALSE)
stopifnot(colnames(raw)[1] == "Geneid")
samp_raw <- colnames(raw)[-1]
samp_names <- basename(samp_raw) %>%
  sub("_Aligned.sortedByCoord.out.bam$", "", .) %>%
  sub("\\.bam$", "", .)

colnames(raw) <- c("gene_id", samp_names)
raw$gene_id <- sub("\\.\\d+$", "", raw$gene_id)
counts <- raw %>%
  mutate(across(-gene_id, as.numeric)) %>%
  column_to_rownames("gene_id") %>%
  as.matrix()

samples <- colnames(counts)
condition <- ifelse(grepl("^DMD", samples, ignore.case = TRUE), "DMD", "Healthy")
stopifnot(all(condition %in% c("DMD","Healthy")))
coldata <- data.frame(row.names = samples,
                      condition = factor(condition, levels = c("Healthy","DMD")))
message("[INFO] Sample counts:"); print(table(coldata$condition))


keep <- rowSums(counts) > 10
counts <- counts[keep, , drop = FALSE]
message(glue("[INFO] Kept {nrow(counts)} genes after low-count filter"))）
write.csv(as.data.frame(counts) %>% rownames_to_column("gene"),
          file.path(out_dir, "counts_matrix.cleaned.csv"),
          row.names = FALSE)

dds <- DESeqDataSetFromMatrix(countData = round(counts),
                              colData   = coldata,
                              design    = ~ condition)
dds <- DESeq(dds)
res <- results(dds, contrast = c("condition","DMD","Healthy"))

vsd <- vst(dds, blind = FALSE)
pdf(file.path(out_dir, "PCA_plot.pdf"), width = 6, height = 5)
plotPCA(vsd, intgroup = "condition")
dev.off()

pdf(file.path(out_dir, "MA_plot.pdf"), width = 6, height = 5)
plotMA(res_shrink, ylim = c(-5,5))
dev.off()