#!/bin/csh -f
#SBATCH -J subtr2 # name of the job
#SBATCH -t 2:00:00 # time requested
#SBATCH -N 1 -n 1  # total number of nodes and processes
#SBATCH -A zerze

set ff = charmm36

set proot = proteina

set this = opes

set nnode = 16

set nd = 0
mkdir -p data/subtrajectory

while ( $nd < $nnode )
        gmx_gpu trjconv -s ${nd}/${proot}_${ff}_${this}_nd.tpr \
                -f data/xtc_prot/2000ns_${proot}_${ff}_${this}_all_nd${nd}_prot.xtc \
                -drop data/hills/${nd}/2000ns_conditions_Q_0.77-0.92_rg_1.2-1.9.xvg -dropunder 0.25 \
                -o data/subtrajectory/2000ns_${proot}_${ff}_${this}_nd${nd}_prot_Q_0.77-0.92_rg_1.2-1.9.xtc<<EOD
1
EOD
        @ nd++
end
