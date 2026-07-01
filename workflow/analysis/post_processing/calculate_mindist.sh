#!/bin/bash
#SBATCH -J mindist
#SBATCH -t 20:00:00
#SBATCH -N 1 -n 1
set -euo pipefail

# Calculate minimum distances for each replica trajectory.
# Edit the variables below for a different system.

nreplicas=16
start_replica=0
ff="charmm36"
proot="proteina"
method="opes"
data_dir="data"
traj_prefix="2000ns"
gmx="gmx_gpu"
group_a=1
group_b=""
outdir="${data_dir}/mindist"
prefix="${traj_prefix}_mindist_nd"

mkdir -p "$outdir"

stop_replica=$((start_replica + nreplicas - 1))

for nd in $(seq "$start_replica" "$stop_replica"); do
    xtc="${data_dir}/xtc_prot/${traj_prefix}_${proot}_${ff}_${method}_all_nd${nd}_prot.xtc"
    tpr="${nd}/${proot}_${ff}_${method}_nd.tpr"
    out="${outdir}/${prefix}${nd}.xvg"

    echo "Running mindist for replica ${nd} -> ${out}"
    if [[ -n "$group_b" ]]; then
        "${gmx}" mindist -f "$xtc" -s "$tpr" -od "$out" -pi <<EOD
${group_a}
${group_b}
EOD
    else
        "${gmx}" mindist -f "$xtc" -s "$tpr" -od "$out" -pi <<EOD
${group_a}

EOD
    fi
done
