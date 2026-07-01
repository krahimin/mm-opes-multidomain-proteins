#!/bin/bash
#SBATCH -J rmsf-M2B # name of the job
#SBATCH -t 1:30:00 # time requested
#SBATCH -N 1  -n 1# total number of nodes and processes
#SBATCH -A zerze

mkdir -p data/rmsf


gmx_gpu rmsf -f data/xtc_prot/2000ns_proteina_charmm36_opes_all_nds.xtc -od data/rmsf/rmsf_D1T1.xvg -n index.ndx -dt 100 -s 0/proteina_charmm36_opes_nd.tpr<<EOD
32
EOD
end

gmx_gpu rmsf -f data/xtc_prot/2000ns_proteina_charmm36_opes_all_nds.xtc -od data/rmsf/rmsf_D1T2.xvg -n index.ndx -dt 100 -s 0/proteina_charmm36_opes_nd.tpr<<EOD
33
EOD
end


gmx_gpu rmsf -f data/xtc_prot/2000ns_proteina_charmm36_opes_all_nds.xtc -od data/rmsf/rmsf_D2T1.xvg -n index.ndx -dt 100 -s 0/proteina_charmm36_opes_nd.tpr<<EOD
34
EOD
end

gmx_gpu rmsf -f data/xtc_prot/2000ns_proteina_charmm36_opes_all_nds.xtc -od data/rmsf/rmsf_D2T2.xvg -n index.ndx -dt 100 -s 0/proteina_charmm36_opes_nd.tpr<<EOD
35
EOD
end



