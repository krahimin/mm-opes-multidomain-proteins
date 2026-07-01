#!/bin/csh -f
#SBATCH -J 2B_dssp
#SBATCH -t 4:00:00
#SBATCH -N 1 -n 1 
#SBATCH -A zerze
#BATCH --mail-user=krahimin@cougarnet.uh.edu
#SBATCH --mail-type=BEGIN,END,FAIL
set ff = charmm36
set this = opes
set proot = proteina 
set nnode = 8
set nd = 6
mkdir -p data/dssp
while( $nd < $nnode )
	gmx_gpu do_dssp -f data/xtc_prot/2000ns_${proot}_${ff}_${this}_all_nd${nd}_prot.xtc \
    		-o data/dssp/${proot}_${ff}_${this}_all_nd${nd}_prot.xpm \
    		-sc data/dssp/${proot}_${ff}_${this}_all_nd${nd}_prot.xvg \
    		-s ${nd}/${proot}_${ff}_${this}_nd.tpr -b 0 <<EOD
1
EOD
		@ nd++
end

