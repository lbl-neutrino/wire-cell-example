#!/usr/bin/env bash

infiles=(
    /global/cfs/cdirs/m5170/data/fom_inputs/np02vd_raw_run039252_1176_df-s03-d3_dw_0_20250830T054542.hdf5
    /global/cfs/cdirs/m5170/data/fom_inputs/np02vd_raw_run039255_0088_df-s04-d1_dw_0_20250830T114841.hdf5
    /global/cfs/cdirs/m5170/data/fom_inputs/np02vd_raw_run039273_1218_df-s02-d2_dw_0_20250901T023257.hdf5
    /global/cfs/cdirs/m5170/data/fom_inputs/np02vd_raw_run039350_2842_df-s04-d2_dw_0_20250911T235510.hdf5
)

models=(CP49 unet)
device=cpu
nruns=3

for infile in "${infiles[@]}"; do
    for model in "${models[@]}"; do
        ./run_lar_for_fom.sh "$infile" "$model" "$device" "$nruns"
    done
done
