#!/usr/bin/env bash
# Run Cell Ranger count for single-nucleus RNA-seq (10x).
# Input: FASTQ per sample (or sample name in fastqs). Output: one count directory per sample (e.g. DMD1_count/outs).
# Requires: Cell Ranger; reference built with cellranger mkref (e.g. refdata-cellranger-hg19-3.0.0).
# Chemistry: SC3Pv3; --include-introns for nuclear RNA. Adjust REF, FASTQ_DIR, and sample IDs for your data.
set -euo pipefail

# --- Paths and parameters ---
REF=./humanDMD/refdata-cellranger-hg19-3.0.0
FASTQ_DIR=./humanDMD/fastq
CORES=4
MEM=128

cd "${FASTQ_DIR}"

# DMD1: SRR16555252
cellranger count \
  --id=DMD1_count \
  --create-bam=true \
  --transcriptome="${REF}" \
  --fastqs="${FASTQ_DIR}" \
  --sample=SRR16555252 \
  --chemistry=SC3Pv3 \
  --include-introns=true \
  --localcores=${CORES} --localmem=${MEM}

# DMD2: SRR16555253
cellranger count \
  --id=DMD2_count \
  --create-bam=true \
  --transcriptome="${REF}" \
  --fastqs="${FASTQ_DIR}" \
  --sample=SRR16555253 \
  --chemistry=SC3Pv3 \
  --include-introns=true \
  --localcores=${CORES} --localmem=${MEM}

# DMD3: SRR16555254, SRR16596797
cellranger count \
  --id=DMD3_count \
  --create-bam=true \
  --transcriptome="${REF}" \
  --fastqs="${FASTQ_DIR}" \
  --sample=SRR16555254,SRR16596797 \
  --chemistry=SC3Pv3 \
  --include-introns=true \
  --localcores=${CORES} --localmem=${MEM}

# Healthy1: SRR16555255
cellranger count \
  --id=Healthy1_count \
  --create-bam=true \
  --transcriptome="${REF}" \
  --fastqs="${FASTQ_DIR}" \
  --sample=SRR16555255 \
  --chemistry=SC3Pv3 \
  --include-introns=true \
  --localcores=${CORES} --localmem=${MEM}

# Healthy2: SRR16555256
cellranger count \
  --id=Healthy2_count \
  --create-bam=true \
  --transcriptome="${REF}" \
  --fastqs="${FASTQ_DIR}" \
  --sample=SRR16555256 \
  --chemistry=SC3Pv3 \
  --include-introns=true \
  --localcores=${CORES} --localmem=${MEM}
