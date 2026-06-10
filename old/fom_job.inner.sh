#!/usr/bin/env bash

NRUNS=3

device=$1; shift     # cpu or gpu

source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh
DUNE_VERSION=${DUNE_VERSION:-v10_17_00d00}
DUNE_QUALIFIER=${DUNE_QUALIFIER:-e26:prof}
setup dunesw "$DUNE_VERSION" -q "$DUNE_QUALIFIER"
export WIRECELL_PATH=$DUNERECO_DIR/wire-cell-cfg/pgrapher/experiment/protodunevd:$WIRECELL_PATH

if [[ "$device" == "gpu" ]]; then
    offsets=(0 4)
else
    offsets=(0)
fi

for offset in $offsets; do
    # get corresponding line of fom_job.args.txt
    lineno=$((offset + SLURM_PROCID + 1))
    args=$(sed -n ${lineno}p fom_job.args.txt)
    read -ra args <<< "$args"       # split into array

    infile=${args[0]}
    model=${args[1]}

    ./run_lar_for_fom.sh "$infile" "$model" "$device" "$NRUNS"
done
