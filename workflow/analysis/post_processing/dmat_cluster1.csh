#!/bin/bash
#SBATCH -J 2B_dmat # name of the job
#SBATCH -t 1:00:00 # time requested
#SBATCH -N 1  -n 1# total number of nodes and processes
#SBATCH -A zerze
  
prot=proteina
ff=charmm36
this=ptwte
nd=0



/project/zerze/krahimin/DMAT/dmat -s ../em_prot2.pdb -o data/contact_map/cltr1_rc0.4_Q_0.77-0.92_rg_1.2-1.9_contact_map -c 6 data/cluster/2B_linker_cluster1_rc0.4_Q_0.77-0.92_rg_1.2-1.9.xtc

/project/zerze/krahimin/DMAT/dmat -s ../em_prot2.pdb -o data/contact_map/cltr2_rc0.4_Q_0.77-0.92_rg_1.2-1.9_contact_map -c 6 data/cluster/2B_linker_cluster2_rc0.4_Q_0.77-0.92_rg_1.2-1.9.xtc
