#!/bin/csh -f
#SBATCH -J rama
#SBATCH -t 4:30:00
#SBATCH -N 1 -n 1
#
# Calculate Ramachandran angles for a combined protein trajectory.
# Edit the variables below for a different system.

set ff = charmm36
set proot = proteina
set method = opes
set data_dir = data
set traj_prefix = 2000ns
set gmx = gmx_gpu
set tpr = 0/${proot}_${ff}_${method}_nd.tpr
set traj = ${data_dir}/xtc_prot/${traj_prefix}_${proot}_${ff}_${method}_all_nds.xtc
set output = ${data_dir}/rama/ram_trj.xvg

mkdir -p ${data_dir}/rama

${gmx} rama \
	-s ${tpr} \
	-f ${traj} \
	-o ${output}
