# Modeling

The modeling stage contains the files needed to run MM-OPES simulations with GROMACS and PLUMED.

Key files:

- `workflow/modeling/plumed/plumed.dat`: production PLUMED input.
- `workflow/modeling/mdp/`: production MDP files for the temperature/replica set.
- `workflow/modeling/slurm/template.cmd`: SLURM production template.

Contact-map PLUMED files used for trajectory reruns are post-processing inputs and live in `workflow/analysis/post_processing/`.

The SLURM template assumes 16 replicas in directories named `0` through `15`, each containing the corresponding `.tpr`, `plumed.dat`, and checkpoint files.

Before submitting, edit:

- SLURM account, job name, walltime, GPU/node settings, and email.
- PLUMED source path.
- `ng`, `proot`, `ff`, and `this` variables if the system name or force field changes.
- Input/output root names if they differ from `proteina_charmm36_opes_nd`.
