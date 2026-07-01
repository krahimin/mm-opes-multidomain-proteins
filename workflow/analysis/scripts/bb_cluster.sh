#!/bin/bash
#SBATCH -J 2B_clstring
#SBATCH -t 2:00:00
#SBATCH -N 1 -n 1 
#SBATCH -A zerze

mkdir -p data/cluster
rcut=0.5

node=0
method=gromos
cond=Q_0.77-0.92_rg_1.2-1.9
oroot=data/cluster/bb_cluster_2000ns_rc${rcut}_${cond}

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
27
1
EOD 
