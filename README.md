# MM-OPES workflow for multidomain proteins

This repository organizes a GROMACS/PLUMED MM-OPES workflow for multidomain proteins. It is structured around three stages:

1. `workflow/preparation`: system preparation, equilibration, and native-contact setup.
2. `workflow/modeling`: PLUMED inputs, MDP files, and SLURM submission template for MM-OPES runs.
3. `workflow/analysis`: trajectory cleanup, Rg/DSSP/Ramachandran calculations, subtrajectory extraction, clustering, contact-map reruns, and plotting.

The current example is based on the Protein A system. Large trajectories, checkpoints, logs, and generated analysis products are intentionally ignored by git.

## Repository Layout

```text
.
├── docs/                         # Human-readable workflow notes
├── workflow/
│   ├── preparation/              # GROMACS preparation and equilibration files
│   ├── modeling/                 # PLUMED, MDP, and SLURM run templates
│   └── analysis/
│       ├── post_processing/      # Analysis and post-processing scripts
│       └── plots/                # Plotting notebooks
├── examples/                     # System-specific worked examples
├── data/                         # Local generated data; ignored except .gitkeep
├── results/                      # Local processed outputs; ignored except .gitkeep
└── figures/                      # Local generated plots; ignored except .gitkeep
```

## Requirements

- GROMACS with PLUMED support
- PLUMED 2.x
- SLURM for cluster runs
- `csh` and `bash`
- Python 3 with NumPy, SciPy, Matplotlib, MDAnalysis, and Jupyter

Install the Python plotting environment with:

```bash
python3 -m pip install -r requirements.txt
```

## Quick Start

1. Prepare the system using the commands in `workflow/preparation/commands.txt`.
2. Equilibrate with `workflow/preparation/equilibration.sh` and the MDP files in `workflow/preparation/mdp_eq/`.
3. Build native-contact lists with `workflow/preparation/make_q_python3.py` and edit them with the provided Q-list scripts.
4. Configure MM-OPES inputs in `workflow/modeling/plumed/` and `workflow/modeling/mdp/`.
5. Submit production runs with `workflow/modeling/slurm/template.cmd`.
6. Clean and combine outputs with `workflow/analysis/post_processing/merge_colvar_rg.csh`.
7. Run analysis scripts for Rg, DSSP, Ramachandran, subtrajectories, clustering, and contact maps.
8. Plot and inspect results in `workflow/analysis/plots/2B-linker.ipynb`.

For a different protein system, edit the variable block at the top of each script before running it.

## Data Policy

Do not commit raw trajectories, checkpoints, energy files, generated cluster outputs, or SLURM logs. Keep those files locally in `data/`, `results/`, `figures/`, or system-specific run folders.

Author: [@krahimin](https://github.com/krahimin)
