#!/bin/bash
#SBATCH -J 2B-eq
#SBATCH -t 1:00:00
#SBATCH -N 1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=8
#SBATCH --gpus-per-node=2
#SBATCH -A zerze

module purge
module add cmake/3.17.3
module add CUDA/.11.4.1
module add intel-oneapi

proot=proteina
ff=charmm36_tip3p
fileroot=${proot}_${ff}

# Create directories if they don't exist
mkdir -p data/tpr data/gro data/ene data/log

# --- NVT Room T ---
gmx_gpu grompp -v -f mdp_eq/nvt_roomT.mdp -c em.gro \
        -o data/tpr/${fileroot}_nvt_roomT.tpr -p topol.top

mpirun gmx_gpu mdrun -v -ntomp 1 -s data/tpr/${fileroot}_nvt_roomT.tpr \
        -c data/gro/${fileroot}_nvt_roomT.gro \
        -e data/ene/${fileroot}_nvt_roomT.edr \
        -g data/log/${fileroot}_nvt_roomT.log

# --- NPT Room T ---
gmx_gpu grompp -v -maxwarn 1 -f mdp_eq/npt_roomT.mdp -c data/gro/${fileroot}_nvt_roomT.gro \
        -o data/tpr/${fileroot}_npt_roomT.tpr -p topol.top

mpirun gmx_gpu mdrun -v -ntomp 1 -s data/tpr/${fileroot}_npt_roomT.tpr \
        -c data/gro/${fileroot}_npt_roomT.gro \
        -e data/ene/${fileroot}_npt_roomT.edr \
        -g data/log/${fileroot}_npt_roomT.log

# --- NPT High T ---
gmx_gpu grompp -v -maxwarn 1 -f mdp_eq/npt_highT.mdp -c data/gro/${fileroot}_npt_roomT.gro \
        -o data/tpr/${fileroot}_npt_highT.tpr -p topol.top

mpirun gmx_gpu mdrun -v -ntomp 1 -s data/tpr/${fileroot}_npt_highT.tpr \
        -c data/gro/${fileroot}_npt_highT.gro \
        -e data/ene/${fileroot}_npt_highT.edr \
        -g data/log/${fileroot}_npt_highT.log

# --- NVT High T ---
gmx_gpu grompp -v -maxwarn 1 -f mdp_eq/nvt_highT.mdp -c data/gro/${fileroot}_npt_highT.gro \
        -o data/tpr/${fileroot}_nvt_highT.tpr -p topol.top

mpirun gmx_gpu mdrun -v -ntomp 1 -s data/tpr/${fileroot}_nvt_highT.tpr \
        -c data/gro/${fileroot}_nvt_highT.gro \
        -e data/ene/${fileroot}_nvt_highT.edr \
        -g data/log/${fileroot}_nvt_highT.log

# --- NPT Run T ---
gmx_gpu grompp -v -maxwarn 1 -f mdp_eq/npt_runT.mdp -c data/gro/${fileroot}_nvt_highT.gro \
        -o data/tpr/${fileroot}_npt_runT.tpr -p topol.top

mpirun gmx_gpu mdrun -v -ntomp 1 -s data/tpr/${fileroot}_npt_runT.tpr \
        -c data/gro/${fileroot}_npt_runT.gro \
        -e data/ene/${fileroot}_npt_runT.edr \
        -g data/log/${fileroot}_npt_runT.log

# --- NVT Run T ---
gmx_gpu grompp -v -maxwarn 1 -f mdp_eq/nvt_runT.mdp -c data/gro/${fileroot}_npt_runT.gro \
        -o data/tpr/${fileroot}_nvt_runT.tpr -p topol.top

mpirun gmx_gpu mdrun -v -ntomp 1 -s data/tpr/${fileroot}_nvt_runT.tpr \
        -c data/gro/${fileroot}_nvt_runT.gro \
        -e data/ene/${fileroot}_nvt_runT.edr \
        -g data/log/${fileroot}_nvt_runT.log

# --- NPT Run T2 ---
gmx_gpu grompp -v -maxwarn 1 -f mdp_eq/npt_runT2.mdp -c data/gro/${fileroot}_nvt_runT.gro \
        -o data/tpr/${fileroot}_npt_runT2.tpr -p topol.top

mpirun gmx_gpu mdrun -v -ntomp 1 -s data/tpr/${fileroot}_npt_runT2.tpr \
        -c data/gro/${fileroot}_npt_runT2.gro \
        -e data/ene/${fileroot}_npt_runT2.edr \
        -g data/log/${fileroot}_npt_runT2.log
