#!/bin/bash
#SBATCH -J nd14_2B_dmat # name of the job
#SBATCH -t 2:00:00 # time requested
#SBATCH -N 1  -n 1# total number of nodes and processes
#SBATCH -A zerze

# Configuration
nd=14
INPUT_TRAJ="2000ns_proteina_charmm36_opes_all_nd14_prot.xtc"
INPUT_TPR="proteina_charmm36_opes_nd.tpr" # Ensure you have the matching TPR
STRIDE=100000                 # 100 ns in picoseconds
TOTAL_SEGMENTS=20

for i in $(seq 0 $((TOTAL_SEGMENTS - 1)))
do
    # Calculate start and end times
    START=$((i * STRIDE))
    END=$(((i + 1) * STRIDE))
    
    # Format output filename (e.g., traj_0_100.xtc)
    OUTPUT="subtraj_nd14_${START}_${END}.xtc"
    
    echo "Processing segment: $START to $END ps..."

    # Run trjconv
    # 'echo 0' selects the 'System' group (usually index 0)
    gmx trjconv -f data/xtc_prot/"$INPUT_TRAJ" -s 5/"$INPUT_TPR" -o data/xtc_prot/"$OUTPUT" -b $START -e $END<<EOD
1
EOD
done

echo "Splitting complete. 20 segments generated."

DMAT_PATH="/project/zerze/krahimin/DMAT/dmat"
REF_PDB="em_prot2.pdb"
INPUT_DIR="data/xtc_prot"
OUTPUT_DIR="data/contact_map"
STRIDE=100000
TOTAL_SEGMENTS=20
CUTOFF=6  # Distance cutoff in Angstroms

for i in $(seq 0 $((TOTAL_SEGMENTS - 1)))
do
    # Calculate start and end times to match your previous filenames
    START=$((i * STRIDE))
    END=$(((i + 1) * STRIDE))

    # Define input and output file paths
    INPUT_XTC="${INPUT_DIR}/subtraj_nd${nd}_${START}_${END}.xtc"
    OUTPUT_MAP="${OUTPUT_DIR}/subtrj_nd${nd}_${START}_${END}_contact_map"

    echo "Calculating contact map for: $INPUT_XTC"

    # Run dmat
    # Syntax: dmat -s reference.pdb -o output_prefix -c cutoff trajectory.xtc
    $DMAT_PATH -s "$REF_PDB" -o "$OUTPUT_MAP" -c "$CUTOFF" "$INPUT_XTC"

done
