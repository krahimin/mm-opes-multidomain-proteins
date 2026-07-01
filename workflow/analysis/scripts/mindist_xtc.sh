#!/bin/bash

#SBATCH -J mindist_2B # name of the job
#SBATCH -t 20:00:00 # time requested
#SBATCH -N 1 -n 1  # total number of nodes and processes
#SBATCH -A zerze

# Settings
nwalkers=16
traj_name="proteina_charmm36_opes_nd.part0001.xtc"
tpr_name="proteina_charmm36_opes_nd.tpr"
outdir="data/mindist"
prefix="2000ns_mindist_nd"

mkdir -p "$outdir"

for nd in $(seq 0 $((nwalkers - 1))); do
  xtc="data/xtc_prot/2000ns_proteina_charmm36_opes_all_nd${nd}_prot.xtc"
  tpr="${nd}/${tpr_name}"
  out="${outdir}/${prefix}${nd}.xvg"


  echo "Running mindist for walker ${nd} -> ${out}"
  gmx_gpu mindist -f "$xtc" -s "$tpr" -od "$out" -pi <<'EOD'
1

EOD
done

echo "Done."

