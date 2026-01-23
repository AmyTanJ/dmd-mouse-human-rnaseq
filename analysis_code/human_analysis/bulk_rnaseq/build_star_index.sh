#!/usr/bin/env bash
set -euo pipefail

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
