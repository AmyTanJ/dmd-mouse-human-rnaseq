#!/usr/bin/env bash
# Build a STAR genome index for alignment.
# Input: reference FASTA and GTF (e.g. GRCh38 + GENCODE).
# Output: index in GENOME_DIR. Use --sjdbOverhang read_length-1 for your library.
# Requires: STAR.
set -euo pipefail

# --- Reference and parameters ---
FASTA=./humanDMD/ref/GRCh38.primary_assembly.genome.fa
GTF=./humanDMD/ref/gencode.v39.annotation.gtf
GENOME_DIR=./humanDMD/ref/STAR_GRCh38_gencodev39
THREADS=6

mkdir -p "$GENOME_DIR"

STAR --runThreadN "$THREADS" \
     --runMode genomeGenerate \
     --genomeDir "$GENOME_DIR" \
     --genomeFastaFiles "$FASTA" \
     --sjdbGTFfile "$GTF" \
     --sjdbOverhang 149
