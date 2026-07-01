#!/bin/csh -f
#SBATCH -J dssp
#SBATCH -t 14:00:00
#SBATCH -N 1 -n 1
#
# Calculate secondary structure for each protein-only trajectory.
# Edit the variables below for a different system.

set nreplicas = 16
set start_replica = 0
set ff = charmm36
set proot = proteina
set method = opes
set data_dir = data
set traj_prefix = 2000ns
set gmx = gmx_gpu
set dssp_group = 1
set begin_time = 0

@ stop_replica = $start_replica + $nreplicas
set nd = $start_replica

mkdir -p ${data_dir}/dssp

while ( $nd < $stop_replica )
	${gmx} do_dssp \
		-f ${data_dir}/xtc_prot/${traj_prefix}_${proot}_${ff}_${method}_all_nd${nd}_prot.xtc \
		-o ${data_dir}/dssp/${proot}_${ff}_${method}_all_nd${nd}_prot.xpm \
		-sc ${data_dir}/dssp/${proot}_${ff}_${method}_all_nd${nd}_prot.xvg \
		-s ${nd}/${proot}_${ff}_${method}_nd.tpr \
		-b ${begin_time} <<EOD
${dssp_group}
EOD

	@ nd++
end
