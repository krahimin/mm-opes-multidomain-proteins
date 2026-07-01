#!/bin/bash
#SBATCH -J 2B_dmat # name of the job
#SBATCH -t 10:00:00 # time requested
#SBATCH -N 1  -n 1# total number of nodes and processes
#SBATCH -A zerze
  
prot=proteina
ff=charmm36
this=ptwte
nd=0



/project/zerze/krahimin/DMAT/dmat -s em_prot2.pdb -o data/contact_map/2B_linker_contact_map -c 6 data/xtc_prot/2000ns_proteina_charmm36_opes_all_nds.xtc
