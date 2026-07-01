#!/bin/bash
#SBATCH -J cluster_backbone
#SBATCH -t 2:00:00
#SBATCH -N 1 -n 1
set -euo pipefail

# Cluster a selected protein subtrajectory with GROMACS.
# Edit the variables below for a different system.

data_dir="data"
proot="proteina"
ff="charmm36"
method_name="opes"
condition="Q_0.77-0.92_rg_1.2-1.9"
rcut=0.5
method="gromos"
gmx="gmx_gpu"
tpr="0/${proot}_${ff}_${method_name}_nd.tpr"
index="index.ndx"
fit_group=27
output_group=1
dt=400
nst=100
wcl=10

mkdir -p "${data_dir}/cluster"

oroot="${data_dir}/cluster/bb_cluster_2000ns_rc${rcut}_${condition}"

"${gmx}" cluster \
    -f "${data_dir}/subtrajectory/all_nds_prot_${condition}.xtc" \
    -s "${tpr}" \
    -o "${oroot}.xpm" \
    -g "${oroot}.log" \
    -dist "${oroot}_dist.xvg" \
    -ev "${oroot}_ev.xvg" \
    -sz "${oroot}_size.xvg" \
    -cl "${oroot}_clusters.pdb" \
    -clid "${oroot}_clid.xvg" \
    -wcl "${wcl}" -nst "${nst}" \
    -cutoff "${rcut}" -method "${method}" -dt "${dt}" \
    -n "${index}" <<EOD
${fit_group}
${output_group}
EOD
