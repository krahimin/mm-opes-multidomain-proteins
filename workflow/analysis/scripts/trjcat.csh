#!/bin/csh -f
#SBATCH -J prot
#SBATCH -t 1:00:00
#SBATCH -N 1 -n 1 
#SBATCH -A zerze



set ff = charmm36

set proot = proteina

set ns = 3
#trjcat below has to be changed manually for change in ns

set this = opes

set nnode = 16

set nd = 0

while ( $nd < $nnode )

	gmx_gpu trjcat -f data/xtc_prot/${proot}_${ff}_${this}_s{1,2,3}_nd${nd}_prot.xtc \
                -o data/xtc_prot/2000ns_${proot}_${ff}_${this}_all_nd${nd}_prot.xtc

	@ nd++



end

#gmx_gpu trjcat -cat -f data/xtc_prot_800ns/1438ns_${proot}_${ff}_${this}_all_nd{0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19}_prot.xtc \
#        -o data/xtc_prot_800ns/1438ns_${proot}_${ff}_${this}_all_nds_prot.xtc

