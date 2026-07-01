#!/bin/csh -f
#SBATCH -J rama # name of the job
#SBATCH -t 4:30:00 # time requested
#SBATCH -N 1  -n 1# total number of nodes and processes
#SBATCH -A zerze

set ff = charmm36

set proot = proteina

set this = opes

mkdir -p data/rama
gmx_gpu rama -s 0/${proot}_${ff}_${this}_nd.tpr \
	-f data/xtc_prot/2000ns_proteina_charmm36_opes_all_nds.xtc \
	-o data/rama/ram_trj.xvg 


