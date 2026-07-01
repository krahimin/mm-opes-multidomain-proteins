#!/bin/bash
#SBATCH -J 5-2B_dmat # name of the job
#SBATCH -t 1:05:00 # time requested
#SBATCH -N 1  -n 1# total number of nodes and processes
#SBATCH -A zerze

# Configuration
DMAT_PATH="/project/zerze/krahimin/DMAT/dmat"
REF_PDB="em_prot2.pdb"
INPUT_DIR="data/xtc_prot"
OUTPUT_DIR="data/contact_map"
STRIDE=100000
TOTAL_SEGMENTS=20
CUTOFF=6  # Distance cutoff in Angstroms

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

for i in $(seq 0 $((TOTAL_SEGMENTS - 1)))
do
    # Calculate start and end times to match your previous filenames
    START=$((i * STRIDE))
    END=$(((i + 1) * STRIDE))
    
    # Define input and output file paths
    INPUT_XTC="${INPUT_DIR}/subtraj_nd5_${START}_${END}.xtc"
    OUTPUT_MAP="${OUTPUT_DIR}/subtrj_nd5_${START}_${END}_contact_map"

    echo "Calculating contact map for: $INPUT_XTC"

    # Run dmat
    # Syntax: dmat -s reference.pdb -o output_prefix -c cutoff trajectory.xtc
    $DMAT_PATH -s "$REF_PDB" -o "$OUTPUT_MAP" -c "$CUTOFF" "$INPUT_XTC"

done

echo "All contact maps generated in $OUTPUT_DIR."
