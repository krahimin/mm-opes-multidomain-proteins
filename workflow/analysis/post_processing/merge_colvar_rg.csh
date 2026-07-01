#!/bin/csh -f
#
# Merge per-replica COLVAR data with radius-of-gyration data.
# Edit the variables below for a different system.
#
# Inputs:
#   ${REPLICA_DIR_PREFIX}${replica}/colvar.${replica}
#   ${DATA_DIR}/rg/${TRAJ_PREFIX}_bck${replica}_rg.xvg
#
# Outputs:
#   ${DATA_DIR}/hills/${replica}/pasted_2000ns

set nreplicas = 16
set start_replica = 0
set colvar_duplicate_line = 1380003
set colvar_stride = 20
set rg_header_lines = 27
set data_dir = data
set replica_dir_prefix = ""
set traj_prefix = 2000ns
set colvar_header = "#! FIELDS time ene cmap mt.ene umb.cmap opes.bias"
set merged_header = "#! FIELDS time ene cmap mt.ene umb.cmap opes.bias time rg"

@ stop_replica = $start_replica + $nreplicas
set nd = $start_replica

mkdir -p ${data_dir}/hills

while ( $nd < $stop_replica )
	mkdir -p ${data_dir}/hills/${nd}

	sed -e "${colvar_duplicate_line}d" ${replica_dir_prefix}${nd}/colvar.${nd} > ${data_dir}/hills/${nd}/${traj_prefix}_colvar_nonrepeated.${nd}
	grep -v "$colvar_header" ${data_dir}/hills/${nd}/${traj_prefix}_colvar_nonrepeated.${nd} > ${data_dir}/hills/${nd}/colvar.${nd}
	awk "NR==1 || NR % ${colvar_stride}==1" ${data_dir}/hills/${nd}/colvar.${nd} > ${data_dir}/hills/${nd}/everynth

	sed "1,${rg_header_lines}d" ${data_dir}/rg/${traj_prefix}_bck${nd}_rg.xvg > ${data_dir}/hills/${nd}/${nd}_heavy_rg.xvg
	awk '{print $1, $2}' ${data_dir}/hills/${nd}/${nd}_heavy_rg.xvg > ${data_dir}/hills/${nd}/temp_rg_cols
	paste ${data_dir}/hills/${nd}/everynth ${data_dir}/hills/${nd}/temp_rg_cols > ${data_dir}/hills/${nd}/pasted2
	echo "$merged_header" | cat - ${data_dir}/hills/${nd}/pasted2 > ${data_dir}/hills/${nd}/pasted_2000ns

	@ nd ++
end
