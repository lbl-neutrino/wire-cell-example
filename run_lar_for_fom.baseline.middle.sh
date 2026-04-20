#!/usr/bin/env bash

# NOTE: Make sure that the current working directory contains a `ts-model`
# directory with CP49.ts etc. (See /global/cfs/cdirs/m5170/ts-model).
# Otherwise you'll get an error saying "no TorchScript model file provided".

# models=(CP49 unet)
## it appears that the unet model doesn't work on CPUs
## ("Legacy model format is not supported on mobile.")
models=(CP49)
device=cpu
nruns=3

source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh
setup dunesw v10_17_00d00 -q e26:prof
export FHICL_FILE_PATH=$PWD:$FHICL_FILE_PATH
export WIRECELL_PATH=$PWD:$DUNERECO_DIR/wire-cell-cfg/pgrapher/experiment/protodunevd:$WIRECELL_PATH
export HDF5_USE_FILE_LOCKING=FALSE

infile=$1; shift
model=${models[0]}
index=$SLURM_PROCID

sleep $((RANDOM % 120))

./run_lar_for_fom.baseline.inner.sh "$infile" "$model" "$device" "$nruns" "$index"
