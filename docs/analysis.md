# Analysis

Analysis scripts are in `workflow/analysis/scripts/`.

Typical order:

1. Extract protein-only trajectories with `extract_prot.csh`.
2. Concatenate or split trajectories with `trjcat.csh` and `split_xtc.sh`.
3. Calculate radius of gyration with `rg_cal.csh`.
4. Combine COLVAR and Rg data with `all_data.csh`.
5. Identify frame ranges by Q/Rg conditions with `conditions_range_Q_rg.sh`.
6. Build subtrajectories with the `subtrajectory_*.csh` scripts.
7. Calculate DSSP with `calc_dssp.csh` or `calc_dssp2.csh`.
8. Calculate Ramachandran data with `rama.csh`.
9. Cluster selected subtrajectories with `bb_cluster*.sh`.
10. Rerun contact-map calculations with `rerun_cmaps_dmn*.sh`.
11. Plot and inspect results in `notebooks/2B-linker.ipynb`.

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
