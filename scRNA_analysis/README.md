# 🧪 Single-cell RNA-seq and RNA velocity analysis (sex-chimeric dataset)

This folder contains Jupyter notebooks for end-to-end analysis of the sex-chimeric single-cell RNA-seq dataset: preprocessing, clustering, macrophage-focused analysis, differential expression, pathway enrichment, and RNA velocity.

## 📁 Overview

| Notebook | Description |
|----------|-------------|
| **scrna_analysis.ipynb** | Load 10x count matrices, QC, normalization, Harmony integration, Leiden clustering, sex label assignment, macrophage subsetting and reclustering, differential expression and pathway enrichment (GO/Reactome). |
| **velocyto_preprocessing.ipynb** | Load Velocyto loom files, concatenate samples, transfer metadata, and merge velocity matrices into AnnData for downstream velocity estimation. |
| **velocyto_analysis.ipynb** | Run RNA velocity (scVelo dynamical model), visualize velocity fields and streamlines, and perform downstream analysis (pseudotime, PAGA). |

## 🧰 Prerequisites

- **Inputs**
  - 10x Genomics feature-barcode matrices for all samples, as produced by the upstream preprocessing pipeline (see the repository’s 10x preprocessing documentation).
  - Velocyto-generated `.loom` files per sample, if running the velocity workflow.
  - **CellSexID_pred/** — Predicted sex labels per dataset (`predicted_labels_dataset_1.csv` through `predicted_labels_dataset_4.csv`) for use in `scrna_analysis.ipynb`. See [CellSexID](https://www.cell.com/cell-reports-methods/fulltext/S2667-2375(25)00217-6) for the method.

- **Environment**
  - Python with: **scanpy**, **scvelo**, **cellrank**, **anndata**, **pandas**, **numpy**, **matplotlib**, **seaborn**, and (for scrna_analysis) **harmony** (e.g. `scanpy.external.pp.harmony_integrate`), **scrublet**, **gseapy** (or equivalent for pathway enrichment). Install via pip or conda as needed.

Path and file names in the notebooks may assume a specific project layout; adjust paths (e.g. to 10x and Velocyto outputs) to match your environment.

## 📚 References

- Pathway gene sets (mouse GO and Reactome): [MSigDB 2023.2 Mm](https://data.broadinstitute.org/gsea-msigdb/msigdb/release/2023.2.Mm/).
