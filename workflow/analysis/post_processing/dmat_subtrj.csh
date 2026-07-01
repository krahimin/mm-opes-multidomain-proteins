#!/bin/bash
#SBATCH -J 2B_dmat # name of the job
#SBATCH -t 3:00:00 # time requested
#SBATCH -N 1  -n 1# total number of nodes and processes
#SBATCH -A zerze
  
prot=proteina
ff=charmm36
this=ptwte
nd=0



/project/zerze/krahimin/DMAT/dmat -s em_prot2.pdb -o data/contact_map/2B_linker_contact_map_all_nds_prot_Q_0.55-0.73_rg_1.2-1.9 -c 6 data/subtrajectory/all_nds_prot_Q_0.55-0.73_rg_1.2-1.9.xtc
