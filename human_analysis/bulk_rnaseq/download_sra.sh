#!/usr/bin/env bash
# Download SRA runs via prefetch (NCBI SRA Toolkit).
# Output: .sra files under OUT_SRA_DIR (default ./humanDMD/2nd_DMD/SRA).
# Requires: SRA Toolkit (prefetch). Adjust the SRRS array for your accessions.
set -euo pipefail

# --- Paths and parameters ---
OUT_SRA_DIR="./humanDMD/2nd_DMD/SRA"
THREADS=8

SRRS=(
  SRR25143906 SRR25143907 SRR25143908 SRR25143909
  SRR25143910 SRR25143911 SRR25143912 SRR25143913
  SRR24750870 SRR24750872 SRR24750875 SRR24750884
  SRR24750886 SRR24750888 SRR24750890 SRR24750891
  SRR24750893 SRR24750895 SRR24750897 SRR24750899
  SRR24750902
)

mkdir -p "${OUT_SRA_DIR}"
cd "${OUT_SRA_DIR}"

export NCBI_SETTINGS="${OUT_SRA_DIR}/ncbi-settings.db"

echo "[INFO] Start prefetch into ${OUT_SRA_DIR}"
for SRR in "${SRRS[@]}"; do
  echo "[INFO] prefetch ${SRR}"
  for i in 1 2 3; do
    if prefetch --max-size unlimited --progress --transport https "${SRR}"; then
      break
    fi
    echo "[WARN] prefetch ${SRR} failed (attempt ${i}), retrying..."
    sleep 10
  done
done

echo "[DONE] All SRA downloaded to ${OUT_SRA_DIR}"
