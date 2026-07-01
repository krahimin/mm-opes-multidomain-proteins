#!/bin/bash
set -euo pipefail

# Build binary time masks for frames satisfying Q and Rg windows.
# Edit the variables below for a different system.

nreplicas=16
start_replica=0
data_dir="data"
q_windows="0.55:0.73,0.77:0.92"
rg_min=1.2
rg_max=1.9
q_col=3
rg_col=8

stop_replica=$((start_replica + nreplicas - 1))

IFS=',' read -r -a windows <<< "$q_windows"

for window in "${windows[@]}"; do
    q_min="${window%%:*}"
    q_max="${window##*:}"
    label="Q_${q_min}-${q_max}_rg_${rg_min}-${rg_max}"

    for nd in $(seq "${start_replica}" "${stop_replica}"); do
        input_file="${data_dir}/hills/${nd}/pasted_2000ns"
        output_file="${data_dir}/hills/${nd}/2000ns_conditions_${label}.xvg"

        awk -v q_min="${q_min}" -v q_max="${q_max}" \
            -v rg_min="${rg_min}" -v rg_max="${rg_max}" \
            -v q_col="${q_col}" -v rg_col="${rg_col}" \
            'BEGIN {OFS="\t"}
            !/^#/ && !/^@/ {
                time=$1; Q=$q_col; rg=$rg_col;
                flag = (Q > q_min && Q < q_max && rg > rg_min && rg < rg_max) ? 1 : 0;
                print time, flag;
            }' "$input_file" > "$output_file"
    done
done
