# Analysis

Analysis files are split into `workflow/analysis/post_processing/` for command-line analysis scripts and `workflow/analysis/plots/` for plotting notebooks. The core scripts are reusable templates: edit the variable block at the top of each script for a different protein, force field, replica count, trajectory prefix, or GROMACS index group.

Typical order:

1. Extract protein-only trajectories with `extract_protein_trajectories.csh`.
2. Concatenate or split trajectories with `concatenate_trajectories.csh` and `split_trajectory_windows.sh`.
3. Calculate radius of gyration with `calculate_rg.csh`.
4. Combine COLVAR and Rg data with `merge_colvar_rg.csh`.
5. Identify frame ranges by Q/Rg conditions with `select_frames_by_q_rg.sh`.
6. Build subtrajectories with the `subtrajectory_*.csh` scripts.
7. Calculate DSSP with `calculate_dssp.csh`.
8. Calculate Ramachandran data with `calculate_rama.csh`.
9. Cluster selected subtrajectories with `cluster_backbone.sh` or the domain-specific `bb_cluster_dmn*.sh` examples.
10. Rerun contact-map calculations with `rerun_cmaps_dmn*.sh` and the post-processing PLUMED inputs `plumed_cmap_dmn1.dat` and `plumed_cmap_dmn2.dat`.
11. Plot and inspect results in `workflow/analysis/plots/2B-linker.ipynb`.

Most scripts assume the local generated-data layout used by the original run:

```text
data/
├── hills/
├── rg/
├── xtc_prot/
├── subtrajectory/
├── cluster/
├── cluster_dmn1/
├── cluster_dmn2/
├── dssp/
├── rama/
└── contact_map/
```

Generated data are ignored by git. Commit only reusable scripts, small examples, and documentation.
