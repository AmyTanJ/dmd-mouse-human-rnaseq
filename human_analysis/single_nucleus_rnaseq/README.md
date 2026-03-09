# 🧠 Single-nucleus RNA-seq pipeline (human DMD)

10x single-nucleus RNA-seq analysis: Cell Ranger count, Scanpy preprocessing, bootstrap pseudo-bulk for DESeq2, and Type I IFN pathway analysis (MSigDB GO, heatmaps, Venn diagrams, hypergeometric test).  
Part of [human_analysis](../README.md) (see also bulk RNA-seq).

## 📁 Pipeline overview

| File | Purpose | Main input | Main output |
|------|---------|------------|-------------|
| **preprocess_scrna.sh** | Download SRA → 10x-style FASTQ for Cell Ranger | SRR list (in script) | `./humanDMD/fastq/` (*_I1_001, *_R1_001, *_R2_001) |
| **run_cellranger.sh** | Cell Ranger count per sample | FASTQ + reference | `*_count/outs/` (filtered matrices) |
| **preprocess_scrna.ipynb** | QC, filter, merge, cluster (Leiden), annotate macrophages | Cell Ranger `outs` | Merged AnnData (e.g. `.h5ad`), clusters |
| **bootstrap_analysis.ipynb** | Bootstrap pseudo-bulk counts per condition | Merged AnnData | Pseudo-bulk table for DESeq2 |
| **pathway_analysis.ipynb** | Type I IFN pathways from [MSigDB GO (2025.1.Hs)](https://data.broadinstitute.org/gsea-msigdb/msigdb/release/2025.1.Hs/), heatmap, Venn, hypergeometric test | DE results + GMT | Heatmaps, Venn diagrams, overlap stats |

## 🔗 Run order

1. **preprocess_scrna.sh** — Download SRA and convert to 10x FASTQ (if starting from SRA).
2. **run_cellranger.sh** — Run Cell Ranger count for each sample.
3. **preprocess_scrna.ipynb** — Load 10x matrices, QC, merge, cluster, define cell types (e.g. macrophages).
4. **bootstrap_analysis.ipynb** — Generate bootstrap pseudo-bulk table (e.g. 50×90% per condition) for DESeq2.
5. Run DESeq2 on the pseudo-bulk table in R; use resulting DE table for pathway analysis.
6. **pathway_analysis.ipynb** — Load DE results and GMT; Type I IFN heatmap, Venn diagrams, hypergeometric test.

## 🧰 Prerequisites

- **SRA Toolkit** (prefetch, fasterq-dump), **pigz** — for preprocess_scrna.sh.
- **Cell Ranger** — reference built with `cellranger mkref` (e.g. refdata-cellranger-hg19-3.0.0); chemistry SC3Pv3, `--include-introns` for nuclei.
- **Python** — Scanpy, pandas, numpy, matplotlib, seaborn, scrublet, matplotlib_venn, scipy; for pathway_analysis also a GMT file (e.g. c5.go.v2025.1.Hs.symbols.gmt from MSigDB).
- **R** — DESeq2 (and dependencies) for differential expression on pseudo-bulk counts.

## 📂 Paths

- Scripts use paths under `./humanDMD/` (e.g. `./humanDMD/fastq`, `./humanDMD/refdata-cellranger-...`). Set `REF`, `FASTQ_DIR`, `WORKDIR`, and sample IDs at the top of each script to match your setup.
- Pathway analysis expects DE results (e.g. `./humanDMD/singlen/bootstrap/20/DE_Genes_rld.csv`) and a GMT file (e.g. `./humanDMD/c5.go.v2025.1.Hs.symbols.gmt`).

## 📚 Reference

- **Human single-nucleus RNA-seq data**: Nieves-Rodriguez et al., Frontiers in Genetics 2023, “Transcriptomic analysis of paired healthy human skeletal muscles to identify modulators of disease severity in DMD” ([https://www.frontiersin.org/journals/genetics/articles/10.3389/fgene.2023.1216066/full](https://www.frontiersin.org/journals/genetics/articles/10.3389/fgene.2023.1216066/full)).
