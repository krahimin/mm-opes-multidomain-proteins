# Preparation

The preparation stage follows `workflow/preparation/commands.txt`.

Main steps:

1. Generate the topology and processed structure with `gmx pdb2gmx`.
2. Define the simulation box with `gmx editconf`.
3. Solvate the system with `gmx solvate`.
4. Add ions with `gmx genion`.
5. Rename ions if needed for the selected force field conventions.
6. Energy-minimize with `workflow/preparation/new_em.mdp`.
7. Run equilibration with `workflow/preparation/equilibration.sh`.
8. Generate native-contact lists with `workflow/preparation/make_q_python3.py`.
9. Edit Q lists for full protein or domain-specific contact maps with the Q-list scripts.

Expected local outputs include `.gro`, `.top`, `.tpr`, `.edr`, `.trr`, `.log`, and generated contact-list files. These are ignored by git unless intentionally copied into a small example directory.
