#!/bin/csh -f
#SBATCH -J 2B_rg
#SBATCH -t 1:00:00
#SBATCH -N 1 -n 1 
#SBATCH -A zerze

mkdir -p data/rg

set nnode = 16

set nd = 0

set ff = charmm36

set proot = proteina

set this = opes
mkdir -p data/rg
while ( $nd < $nnode )

	gmx gyrate -s  ${nd}/${proot}_${ff}_${this}_nd.tpr \
 	-f data/xtc_prot/2000ns_${proot}_${ff}_${this}_all_nd${nd}_prot.xtc \
	-o data/rg/2000ns_bck${nd}_rg.xvg <<EOD
4
EOD



        @ nd++
end


