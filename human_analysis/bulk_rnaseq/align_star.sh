#!/usr/bin/env bash
# Align paired-end FASTQ to the reference using STAR; output sorted BAM and index.
# Input: samples_manifest.tsv (sample, R1, R2); STAR index in GENOME_DIR.
# Output: BAM and index per sample in OUT_DIR.
# Requires: STAR, samtools.
set -euo pipefail

# --- Paths and parameters ---
GENOME_DIR=./humanDMD/ref/STAR_GRCh38_gencodev39
SAMPLE_TSV=./humanDMD/2nd_DMD/FASTQ/samples_manifest.tsv
OUT_DIR=./humanDMD/2nd_DMD/star_out
THREADS=8

mkdir -p "$OUT_DIR"

tail -n +2 "$SAMPLE_TSV" | while IFS=$'\t' read -r SAMPLE R1 R2; do
  echo "[STAR] ${SAMPLE}"
  STAR --runThreadN "$THREADS" \
       --genomeDir "$GENOME_DIR" \
       --readFilesIn "$R1" "$R2" \
       --readFilesCommand zcat \
       --outFileNamePrefix "${OUT_DIR}/${SAMPLE}_" \
       --outSAMtype BAM SortedByCoordinate \
       --quantMode TranscriptomeSAM GeneCounts \
       --twopassMode Basic

  samtools index -@ "$THREADS" "${OUT_DIR}/${SAMPLE}_Aligned.sortedByCoord.out.bam"
done
