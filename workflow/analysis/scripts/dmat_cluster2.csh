#!/bin/bash
#SBATCH -J dmn1_dmat # name of the job
#SBATCH -t 1:30:00 # time requested
#SBATCH -N 1  -n 1# total number of nodes and processes
#SBATCH -A zerze
  
prot=proteina
ff=charmm36
this=ptwte
nd=0



/project/zerze/krahimin/DMAT/dmat -s ../em_prot2.pdb -o data/contact_map/cltr1_rc0.4_dmn1_Q_0.55-0.73_rg_1.2-1.9_contact_map -c 6 data/cluster_dmn1/cluster1_dmn1_rc0.4_Q_0.55-0.73_rg_1.2-1.9.xtc

