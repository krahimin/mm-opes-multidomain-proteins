#!/bin/csh -f
#SBATCH -J rg
#SBATCH -t 1:00:00
#SBATCH -N 1 -n 1
#
# Calculate per-replica radius of gyration using GROMACS.
# Edit the variables below for a different system.

set nreplicas = 16
set start_replica = 0
set ff = charmm36
set proot = proteina
set method = opes
set data_dir = data
set traj_prefix = 2000ns
set gmx = gmx_gpu
set rg_group = 4

@ stop_replica = $start_replica + $nreplicas
set nd = $start_replica

mkdir -p ${data_dir}/rg

while ( $nd < $stop_replica )
	${gmx} gyrate \
		-s ${nd}/${proot}_${ff}_${method}_nd.tpr \
		-f ${data_dir}/xtc_prot/${traj_prefix}_${proot}_${ff}_${method}_all_nd${nd}_prot.xtc \
		-o ${data_dir}/rg/${traj_prefix}_bck${nd}_rg.xvg <<EOD
${rg_group}
EOD

	@ nd++
end
