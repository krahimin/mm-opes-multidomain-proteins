#!/bin/csh -f
#SBATCH -J extract_protein
#SBATCH -t 0:30:00
#SBATCH -N 1 -n 1
#
# Extract protein-only trajectories from each replica and concatenate parts.
# Edit the variables below for a different system.

set nreplicas = 16
set start_replica = 0
set nparts = 3
set ff = charmm36
set proot = proteina
set method = opes
set data_dir = data
set traj_prefix = 2000ns
set gmx = gmx_gpu
set protein_group = 1

@ stop_replica = $start_replica + $nreplicas
set nd = $start_replica

mkdir -p ${data_dir}/xtc_prot

while ( $nd < $stop_replica )
	set s = 0
	while ( $s < $nparts )
		@ s++
		${gmx} trjconv \
			-s ${nd}/${proot}_${ff}_${method}_nd.tpr \
			-f ${nd}/${proot}_${ff}_${method}_nd.part000${s}.xtc \
			-o ${data_dir}/xtc_prot/${proot}_${ff}_${method}_s${s}_nd${nd}_prot.xtc \
			-pbc whole <<EOD
${protein_group}
EOD
	end

	${gmx} trjcat \
		-f ${data_dir}/xtc_prot/${proot}_${ff}_${method}_s*_nd${nd}_prot.xtc \
		-o ${data_dir}/xtc_prot/${traj_prefix}_${proot}_${ff}_${method}_all_nd${nd}_prot.xtc

	@ nd++
end
