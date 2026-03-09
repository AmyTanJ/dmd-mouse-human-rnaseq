#!/usr/bin/env bash
# Count reads per gene with featureCounts (strand-specific, -s 2 for reverse).
# Input: BAM from STAR; GTF. Output: gene_counts.matrix.txt (genes x samples).
# Requires: subread (featureCounts).
set -euo pipefail

# --- Paths and parameters ---
GTF=./humanDMD/ref/gencode.v39.annotation.gtf
STAR_OUT=./humanDMD/2nd_DMD/star_out
COUNTS_OUT=./humanDMD/2nd_DMD/counts_s2
THREADS=8

mkdir -p "$COUNTS_OUT"

BAMS=$(ls ${STAR_OUT}/*_Aligned.sortedByCoord.out.bam)

featureCounts -T "$THREADS" -p -B -C -s 2 \
  -a "$GTF" \
  -o "${COUNTS_OUT}/gene_counts.txt" \
  $BAMS

awk 'BEGIN{FS=OFS="\t"} !/^#/{print}' "${COUNTS_OUT}/gene_counts.txt" > "${COUNTS_OUT}/gene_counts.raw.txt"
cut -f1,7- "${COUNTS_OUT}/gene_counts.raw.txt" > "${COUNTS_OUT}/gene_counts.matrix.txt"

echo "[INFO] Counts matrix -> ${COUNTS_OUT}/gene_counts.matrix.txt"
