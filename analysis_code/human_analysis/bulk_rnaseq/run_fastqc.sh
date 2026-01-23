#!/usr/bin/env bash
set -euo pipefail

# ===== 路径与参数 =====
FASTQ_DIR="./humanDMD/2nd_DMD/FASTQ"
OUT_QC_DIR="${FASTQ_DIR}/QC" 
THREADS=8

mkdir -p "${OUT_QC_DIR}"

echo "[INFO] Running FastQC on all FASTQ files in ${FASTQ_DIR}"

fastqc -t "${THREADS}" \
       -o "${OUT_QC_DIR}" \
       "${FASTQ_DIR}"/*.fastq.gz

echo "[INFO] FastQC finished. Reports in: ${OUT_QC_DIR}"

if command -v multiqc &>/dev/null; then
  echo "[INFO] Running MultiQC..."
  multiqc "${OUT_QC_DIR}" -o "${OUT_QC_DIR}"
  echo "[INFO] MultiQC report generated at ${OUT_QC_DIR}/multiqc_report.html"
else
  echo "[WARN] multiqc not found. Install with: pip install multiqc"
fi
