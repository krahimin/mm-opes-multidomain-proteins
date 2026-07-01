#!/bin/csh -f

set nnode = 16

set nd = 0

set line1 = 1380003
mkdir -p data/hills

while ( $nd < $nnode )

#	mkdir -p data/hills/${nd}
#	sed -e "${line1}d" ${nd}/colvar.${nd} > data/hills/${nd}/2000ns_colvar_nonrepeated.${nd}
#	grep -v "#! FIELDS time ene cmap mt.ene umb.cmap opes.bias" data/hills/${nd}/2000ns_colvar_nonrepeated.${nd} > data/hills/${nd}/colvar.${nd}
#       awk 'NR==1 || NR % 20==1' data/hills/${nd}/colvar.${nd} > data/hills/${nd}/everynth

	sed '1,27d' data/rg/2000ns_bck${nd}_rg.xvg > data/hills/${nd}/${nd}_heavy_rg.xvg
       # 4. FIX: Create a temp file for the specific Rg columns
        awk '{print $1, $2}' data/hills/${nd}/${nd}_heavy_rg.xvg > data/hills/${nd}/temp_rg_cols
       #                 # 5. Paste using the temp file
        paste data/hills/${nd}/everynth data/hills/${nd}/temp_rg_cols > data/hills/${nd}/pasted2 
	echo "#! FIELDS time ene cmap mt.ene umb.cmap opes.bias time rg" | cat - data/hills/${nd}/pasted2 > data/hills/${nd}/pasted_2000ns	

	@ nd ++
end

