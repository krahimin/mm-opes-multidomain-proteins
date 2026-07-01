#!/bin/bash
#SBATCH -J 2B_clstring
#SBATCH -t 2:00:00
#SBATCH -N 1 -n 1 
#SBATCH -A zerze

mkdir -p data/cluster_dmn2
rcut=0.4

node=0
method=gromos
cond=Q_0.55-0.73_rg_1.2-1.9
oroot=data/cluster_dmn2/bb_cluster_2000ns_rc${rcut}_Q_0.55-0.73_rg_1.2-1.9

	gmx cluster -f data/subtrajectory/all_nds_prot_${cond}.xtc \
          -s 0/proteina_charmm36_opes_nd.tpr \
	  -o ${oroot}.xpm \
	  -g ${oroot}.log \
	  -dist ${oroot}_dist.xvg \
	  -ev ${oroot}_ev.xvg \
	  -sz ${oroot}_size.xvg \
	  -cl ${oroot}_clusters.pdb \
	  -clid ${oroot}_clid.xvg \
          -wcl 10 -nst 100 \
	  -cutoff ${rcut} -method ${method} -dt 400 \
	  -n index.ndx <<EOD
29 
1
EOD

# 29 is backbone of dmn2 
