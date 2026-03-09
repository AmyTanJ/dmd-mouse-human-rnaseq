#!/usr/bin/env bash
# Download SRA runs and convert to 10x-style FASTQ (I1, R1, R2) for Cell Ranger.
# Uses fasterq-dump with --include-technical --split-files, then renames by read length (I1 ≤10 bp, R1 ~26–30 bp, R2 ≥50 bp).
# Input: SRR accessions in SRRS array. Output: FASTQs under WORKDIR/fastq with 10x naming (_I1_001, _R1_001, _R2_001).
# Requires: SRA Toolkit (prefetch, fasterq-dump), pigz.
set -euo pipefail

# --- Paths and parameters ---
WORKDIR=./humanDMD
TMPDIR=./humanDMD
THREADS=8
SRRS=(SRR16555254 SRR16596797 SRR16555255 SRR16555256)

detect_len() { zcat "$1" | awk 'NR==2{print length($0); exit}'; }

rename_10x() {
  local S=$1
  local FQDIR="${WORKDIR}/fastq"
  local F1="${FQDIR}/${S}_1.fastq.gz"
  local F2="${FQDIR}/${S}_2.fastq.gz"
  local F3="${FQDIR}/${S}_3.fastq.gz"

  local L1=$(detect_len "$F1"); echo "[len] $(basename "$F1") : $L1"
  local L2=$(detect_len "$F2"); echo "[len] $(basename "$F2") : $L2"
  local L3=$(detect_len "$F3"); echo "[len] $(basename "$F3") : $L3"

  role() { local L=$1; if ((L<=10)); then echo I1; elif ((L>=26 && L<=30)); then echo R1; elif ((L>=50)); then echo R2; else echo UNK; fi; }

  local R_1=$(role "$L1")
  local R_2=$(role "$L2")
  local R_3=$(role "$L3")

  declare -A MAP; MAP[$R_1]=$F1; MAP[$R_2]=$F2; MAP[$R_3]=$F3

  mv -f "${MAP[I1]}" "${FQDIR}/${S}_S1_L001_I1_001.fastq.gz"
  mv -f "${MAP[R1]}" "${FQDIR}/${S}_S1_L001_R1_001.fastq.gz"
  mv -f "${MAP[R2]}" "${FQDIR}/${S}_S1_L001_R2_001.fastq.gz"

}

for SRR in "${SRRS[@]}"; do
  echo ">>> Prefetch ${SRR}"
  prefetch --max-size unlimited "${SRR}" -O "${WORKDIR}/sra"

  echo ">>> fasterq-dump ${SRR}"
  fasterq-dump "${WORKDIR}/sra/${SRR}/${SRR}.sra" \
    --include-technical --split-files \
    -e "${THREADS}" -p \
    --temp "${TMPDIR}" \
    -O "${WORKDIR}/fastq"

  echo ">>> gzip ${SRR} fastqs"
  pigz -p "${THREADS}" \
    "${WORKDIR}/fastq/${SRR}_1.fastq" \
    "${WORKDIR}/fastq/${SRR}_2.fastq" \
    "${WORKDIR}/fastq/${SRR}_3.fastq"

  echo ">>> detect & rename to 10x (${SRR})"
  rename_10x "${SRR}"
done

echo "All FASTQs ready in ${WORKDIR}/fastq"
