#!/usr/bin/env bash
set -euo pipefail

REF=./humanDMD/refdata-cellranger-hg19-3.0.0
FASTQ_DIR=./humanDMD/fastq                       # A步里设定的目录
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

# DMD3:
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
