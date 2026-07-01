#!/bin/bash
#SBATCH -J rmsf-mu-2B # name of the job
#SBATCH -t 2:30:00 # time requested
#SBATCH -N 1  -n 1# total number of nodes and processes
#SBATCH -A zerze

mkdir -p data/rmsf

gmx_gpu rmsf -f data/xtc_prot/2000ns_proteina_charmm36_opes_all_nds.xtc -od data/rmsf/rmsf_all.xvg -n index.ndx -dt 100 -s 0/proteina_charmm36_opes_nd.tpr<<EOD
1
EOD
end

gmx_gpu rmsf -f data/xtc_prot/2000ns_proteina_charmm36_opes_all_nds.xtc -od data/rmsf/rmsf_linker.xvg -n index.ndx -dt 100 -s 0/proteina_charmm36_opes_nd.tpr<<EOD
19
EOD
end

gmx_gpu rmsf -f data/xtc_prot/2000ns_proteina_charmm36_opes_all_nds.xtc -od data/rmsf/rmsf_D1H1.xvg -n index.ndx -dt 100 -s 0/proteina_charmm36_opes_nd.tpr<<EOD
20
EOD
end

gmx_gpu rmsf -f data/xtc_prot/2000ns_proteina_charmm36_opes_all_nds.xtc -od data/rmsf/rmsf_D1H2.xvg -n index.ndx -dt 100 -s 0/proteina_charmm36_opes_nd.tpr<<EOD
21
EOD
end

gmx_gpu rmsf -f data/xtc_prot/2000ns_proteina_charmm36_opes_all_nds.xtc -od data/rmsf/rmsf_D1H3.xvg -n index.ndx -dt 100 -s 0/proteina_charmm36_opes_nd.tpr<<EOD
22
EOD
end

gmx_gpu rmsf -f data/xtc_prot/2000ns_proteina_charmm36_opes_all_nds.xtc -od data/rmsf/rmsf_D2H1.xvg -n index.ndx -dt 100 -s 0/proteina_charmm36_opes_nd.tpr<<EOD
23
EOD
end

gmx_gpu rmsf -f data/xtc_prot/2000ns_proteina_charmm36_opes_all_nds.xtc -od data/rmsf/rmsf_D2H2.xvg -n index.ndx -dt 100 -s 0/proteina_charmm36_opes_nd.tpr<<EOD
24
EOD
end

gmx_gpu rmsf -f data/xtc_prot/2000ns_proteina_charmm36_opes_all_nds.xtc -od data/rmsf/rmsf_D2H3.xvg -n index.ndx -dt 100 -s 0/proteina_charmm36_opes_nd.tpr<<EOD
25
EOD
end


