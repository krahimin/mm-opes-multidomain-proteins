#!/bin/bash
  
#SBATCH -J dmn2_cmpas
#SBATCH -t 0:30:00
#SBATCH -N 1 
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH -A zerze

allcl=16
method=gromos
#rcut=0.5
source /home/krahimin/PROGRAMS/plumed2-v2.8/sourceme.sh
for((clrn=0; clrn < allcl;clrn++))
do
cd /project/zerze/krahimin/proteinA_all/2B/round4_linker/data/hills/
#mkdir ${clrn}
cd ${clrn}

plumed driver --mf_xtc /project/zerze/krahimin/proteinA_all/2B/round4_linker/data/xtc_prot/2000ns_proteina_charmm36_opes_all_nd${clrn}_prot.xtc \
	      --plumed /project/zerze/krahimin/proteinA_all/2B/round4_linker/plumed_cmap_dmn2.dat \
	      --pdb /project/zerze/krahimin/proteinA_all/2B/round4_linker/em_prot2.pdb

done
