#!/bin/bash
Q1=0.55
Q2=0.73

for nd in {0..16}; do
    input_file="data/hills/${nd}/pasted_2000ns"
    output_file="data/hills/${nd}/2000ns_conditions_Q_0.55-0.73_rg_1.2-1.9.xvg"

    awk 'BEGIN {OFS="\t"} 
        !/^#/ && !/^@/ {
            time=$1; rg=$8; Q=$3;
            if (Q > 0.55 && Q < 0.73 && rg > 1.2 && rg < 1.9)
                flag = 1;
            else
                flag = 0;
            print time, flag;
        }' "$input_file" > "$output_file"
done


for nd in {0..16}; do
    input_file="data/hills/${nd}/pasted_2000ns"
    output_file="data/hills/${nd}/2000ns_conditions_Q_0.77-0.92_rg_1.2-1.9.xvg"

    awk 'BEGIN {OFS="\t"} 
        !/^#/ && !/^@/ {
            time=$1; rg=$8; Q=$3;
            if (Q > 0.77 && Q < 0.92 && rg > 1.2 && rg < 1.9)
                flag = 1;
            else
                flag = 0;
            print time, flag;
        }' "$input_file" > "$output_file"
done
