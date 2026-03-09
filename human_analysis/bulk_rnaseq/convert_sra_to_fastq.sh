#!/usr/bin/env bash
# Convert SRA files to paired FASTQ and write a sample manifest.
# Input: .sra under SRA_DIR. Optional: edit NAME[] for human-readable sample labels.
# Output: *_R1.fastq.gz, *_R2.fastq.gz in OUT_FASTQ_DIR; samples_manifest.tsv.
# Requires: SRA Toolkit (fasterq-dump), pigz.
set -euo pipefail

# --- Paths and parameters ---
SRA_DIR="./humanDMD/2nd_DMD/SRA"
OUT_FASTQ_DIR="./humanDMD/2nd_DMD/FASTQ"
THREADS=8

mkdir -p "${OUT_FASTQ_DIR}"

# Optional: uncomment and edit NAME[] for sample labels (e.g. DMD1, Healthy1).
declare -A NAME
# NAME[SRR25143906]="DMD1"
# NAME[SRR25143907]="DMD2"
# NAME[SRR25143908]="DMD3"
# NAME[SRR25143909]="DMD4"
# NAME[SRR25143910]="DMD5"
# NAME[SRR25143911]="DMD6"
# NAME[SRR25143912]="DMD7"
# NAME[SRR25143913]="DMD8"

# NAME[SRR24750870]="Healthy1"
# NAME[SRR24750872]="Healthy2"
# NAME[SRR24750875]="Healthy3"
# NAME[SRR24750884]="Healthy4"
# NAME[SRR24750886]="Healthy5"
# NAME[SRR24750888]="Healthy6"
# NAME[SRR24750890]="Healthy7"
# NAME[SRR24750891]="Healthy8"
# NAME[SRR24750893]="Healthy9"
# NAME[SRR24750895]="Healthy10"
NAME[SRR24750897]="Healthy11"
NAME[SRR24750899]="Healthy12"
NAME[SRR24750902]="Healthy13"

mapfile -t SRRS < <(find "${SRA_DIR}" -type f -name "*.sra" -printf "%f\n" | sed 's/\.sra$//' | sort)
echo "[INFO] Converting SRA -> FASTQ in ${OUT_FASTQ_DIR}"

for SRR in SRR24750897 SRR24750899 SRR24750902; do
  SAMPLE="${NAME[$SRR]:-$SRR}"
  echo "[INFO] fasterq-dump ${SRR}  ->  ${SAMPLE}_R1.fastq.gz / ${SAMPLE}_R2.fastq.gz"

  TMPDIR="${OUT_FASTQ_DIR}/.tmp_${SRR}"
  mkdir -p "${TMPDIR}"

  fasterq-dump --split-files --threads "${THREADS}" \
               --outdir "${TMPDIR}" \
               "${SRA_DIR}/${SRR}/${SRR}.sra"

  pigz -p "${THREADS}" "${TMPDIR}/${SRR}_1.fastq"
  pigz -p "${THREADS}" "${TMPDIR}/${SRR}_2.fastq"

  mv "${TMPDIR}/${SRR}_1.fastq.gz" "${OUT_FASTQ_DIR}/${SAMPLE}_R1.fastq.gz"
  mv "${TMPDIR}/${SRR}_2.fastq.gz" "${OUT_FASTQ_DIR}/${SAMPLE}_R2.fastq.gz"
  rmdir "${TMPDIR}" || true
done

MANIFEST="${OUT_FASTQ_DIR}/samples_manifest.tsv"
{
  echo -e "sample\tR1\tR2"
  for SRR in "${SRRS[@]}"; do
    SAMPLE="${NAME[$SRR]:-$SRR}"
    echo -e "${SAMPLE}\t${OUT_FASTQ_DIR}/${SAMPLE}_R1.fastq.gz\t${OUT_FASTQ_DIR}/${SAMPLE}_R2.fastq.gz"
  done
} > "${MANIFEST}"

echo "[DONE] FASTQs ready at ${OUT_FASTQ_DIR}"
echo "[INFO] Manifest: ${MANIFEST}"
