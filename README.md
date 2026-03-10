# 🧬 Analysis code for type I IFN and DMD mouse studies

This directory contains analysis code for the manuscript **“Type 1 Interferon Mediates Trained Immunity and Muscle Weakness in Duchenne Muscular Dystrophy Mice”** (in preparation). The notebooks and scripts cover mouse sex-chimeric single-cell RNA-seq, human RNA-seq, and IFNAR1 chimeric experiments.

> 📂 **Data availability**: Processed and raw data (e.g. GEO accessions) will be released once the manuscript is accepted.

## 📁 Folder overview

| Folder | Description |
|--------|-------------|
| `scRNA_analysis/` | 🧪 Mouse sex-chimeric single-cell RNA-seq and RNA velocity analysis (Scanpy + scVelo). See `scRNA_analysis/README.md`. |
| `human_analysis/` | 🧍 Human bulk and single-nucleus RNA-seq pipelines (DMD vs healthy): alignment, counting, DE, and pathway analysis. See `human_analysis/README.md`. |
| `IFNKO_exp/` | 🧯 IFNAR1 chimera analyses: label transfer from sex-chimeric reference, pseudo-bulk vs bulk matching, and single-cell deconvolution with scSemiProfiler. See `IFNKO_exp/README.md`. |

## 🔗 How the pieces fit together (high level)

- Use `scRNA_analysis/` to process the mouse sex-chimeric single-cell dataset (QC, clustering, macrophage subsets, pathways, RNA velocity).
- Use `human_analysis/` for human DMD vs healthy bulk and single-nucleus RNA-seq processing and differential expression analyses.
- Use `IFNKO_exp/` to analyse **Ifnar1-/- Donor/mdxHost** and **Ifnar1+/+ Donor/mdxHost** chimeras, including label transfer from the sex-chimeric reference and scSemiProfiler-based bulk deconvolution.

## 📬 Contact

For questions about the code or data, please contact **Jiahui Tan** at `jiahui.tan@mail.mcgill.ca`.

## 📄 License

This analysis code is released under the **MIT License**.
