# Analysis

This directory has two parts:

- `post_processing/`: command-line analysis scripts.
- `plots/`: plotting notebooks.

The post-processing scripts are intended to be reusable templates for MM-OPES analysis. They default to the 2B-linker naming convention, but each script has a short variable block near the top that should be edited for a different protein, force field, replica count, trajectory prefix, or GROMACS index group.

Core scripts:

- `extract_protein_trajectories.csh`: extract protein-only trajectories from each replica.
- `concatenate_trajectories.csh`: concatenate protein-only trajectory parts.
- `calculate_rg.csh`: calculate radius of gyration.
- `merge_colvar_rg.csh`: merge COLVAR and Rg data into one per-replica table.
- `select_frames_by_q_rg.sh`: write binary masks for Q/Rg windows.
- `calculate_dssp.csh`: calculate DSSP secondary-structure time series.
- `calculate_rama.csh`: calculate Ramachandran data.
- `calculate_mindist.sh`: calculate minimum-distance traces.
- `cluster_backbone.sh`: cluster selected subtrajectories.
- `rerun_cmaps_dmn1.sh` and `rerun_cmaps_dmn2.sh`: rerun contact-map calculations using `plumed_cmap_dmn1.dat` and `plumed_cmap_dmn2.dat`.

Several scripts remain specialized for the current 2B-linker analysis, especially domain-specific clustering, contact-map, and RMSF-region scripts. Treat those as worked examples and update paths, group IDs, and residue selections before using them for a different system.

Recommended pattern: copy the script or edit the top variable block, then run it from the project root.
