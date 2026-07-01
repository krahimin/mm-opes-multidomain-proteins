#!/bin/bash

#SBATCH -J 2B # name of the job
#SBATCH -t 168:00:00 # time requested
#SBATCH -N 2  # total number of nodes and processes
#SBATCH -A zerze
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=8
#SBATCH --gpus-per-node=2
#SBATCH --mail-user=krahimin@cougarnet.uh.edu
#SBATCH --mail-type=BEGIN,END,FAIL

module purge
module add GCC cmake
module add cudatoolkit/11.0
module add intel-oneapi/2022.2.0

source /home/kmalekza/PROGRAMS/plumed2-v2.8/sourceme.sh

# Define number of replicas
ng=16
# Which set?
s=1
# Full path to application + application name
application="gmx_gpu mdrun"

# Define variables related to protein and ff
proot="proteina"
ff="charmm36"
fileroot="${proot}_${ff}"
this="opes"

mkdir cpts

nm=$(echo "$ng - 1" | bc)
dirs=0

cp ${dirs}/${fileroot}_${this}_nd.cpt cpts/${dirs}_${SLURM_JOB_ID}.cpt

for i in $(seq 1 $nm); do

cp ${i}/${fileroot}_${this}_nd.cpt cpts/${i}_${SLURM_JOB_ID}.cpt

dirs=${dirs}" "${i}
done

options="-maxh 168 -multidir $dirs \
-v -s ${fileroot}_${this}_nd.tpr \
-x ${fileroot}_${this}_nd.xtc \
-o ${fileroot}_${this}_nd.trr \
-c ${fileroot}_${this}_nd.gro \
-e ${fileroot}_${this}_nd.edr \
-g ${fileroot}_${this}_nd.log \
-plumed plumed.dat \
-cpo ${fileroot}_${this}_nd.cpt \
-cpt 60 \
-cpi ${fileroot}_${this}_nd.cpt -noappend"

echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`

# Launch the MPI executable

mpirun $application $options > outfile_${proot} 2>&1

echo Time is `date`
