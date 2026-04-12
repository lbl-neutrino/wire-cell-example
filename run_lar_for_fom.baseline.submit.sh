#!/usr/bin/env bash

infiles=(
    /global/cfs/cdirs/m5170/data/fom_inputs/np02vd_raw_run039252_1176_df-s03-d3_dw_0_20250830T054542.hdf5
    /global/cfs/cdirs/m5170/data/fom_inputs/np02vd_raw_run039350_2842_df-s04-d2_dw_0_20250911T235510.hdf5
)

for infile in "${infiles[@]}"; do
    sbatch run_lar_for_fom.baseline.outer.sh "$infile"
done
