#!/bin/csh -f
#SBATCH -J concatenate_trajectories
#SBATCH -t 1:00:00
#SBATCH -N 1 -n 1
#
# Concatenate previously extracted protein-only trajectory parts.
# Edit the variables below for a different system.

set nreplicas = 16
set start_replica = 0
set ff = charmm36
set proot = proteina
set method = opes
set data_dir = data
set traj_prefix = 2000ns
set gmx = gmx_gpu

@ stop_replica = $start_replica + $nreplicas
set nd = $start_replica

while ( $nd < $stop_replica )
	${gmx} trjcat \
		-f ${data_dir}/xtc_prot/${proot}_${ff}_${method}_s*_nd${nd}_prot.xtc \
		-o ${data_dir}/xtc_prot/${traj_prefix}_${proot}_${ff}_${method}_all_nd${nd}_prot.xtc

	@ nd++
end
