# 🧍 Human RNA-seq analysis (DMD vs healthy)

Analysis code for human DMD (Duchenne muscular dystrophy) versus healthy samples: bulk RNA-seq and single-nucleus RNA-seq pipelines.

## 📁 Contents

| Folder | Description |
|--------|-------------|
| **[bulk_rnaseq](bulk_rnaseq/)** | 💾 Bulk RNA-seq: SRA download → FASTQ → STAR alignment → featureCounts → DESeq2 (DMD vs healthy). |
| **[single_nucleus_rnaseq](single_nucleus_rnaseq/)** | 🧠 Single-nucleus RNA-seq: 10x/Cell Ranger → preprocessing (Scanpy) → bootstrap pseudo-bulk → DESeq2 → pathway analysis (MSigDB GO). |

## 🔗 Run order (high level)

- **Bulk:** See [bulk_rnaseq/README.md](bulk_rnaseq/README.md) for script order (download_sra → convert → FastQC → STAR → featureCounts → DESeq2).
- **Single-nucleus:** See [single_nucleus_rnaseq/README.md](single_nucleus_rnaseq/README.md) for Cell Ranger → preprocessing → bootstrap → pathway analysis.

## 🧰 Prerequisites

- **Bulk:** SRA Toolkit, FastQC, STAR, samtools, subread, R (DESeq2, tidyverse, etc.).
- **Single-nucleus:** Cell Ranger, Python (Scanpy, pandas, etc.), R for DESeq2 if running bootstrap-based DE.

Paths in scripts use example directories under `./humanDMD/`; adjust to your layout or set variables at the top of each script.

## 📚 Data sources / references

- **Human bulk RNA-seq data**: Scripture-Adams et al., Communications Biology 2022, “Single nuclei transcriptomics of muscle reveals intra-muscular cell dynamics linked to dystrophin loss and rescue” ([https://www.nature.com/articles/s42003-022-03938-0](https://www.nature.com/articles/s42003-022-03938-0)).
- **Human single-nucleus RNA-seq data**: Nieves-Rodriguez et al., Frontiers in Genetics 2023, “Transcriptomic analysis of paired healthy human skeletal muscles to identify modulators of disease severity in DMD” ([https://www.frontiersin.org/journals/genetics/articles/10.3389/fgene.2023.1216066/full](https://www.frontiersin.org/journals/genetics/articles/10.3389/fgene.2023.1216066/full)).
