#!/usr/bin/env bash

source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh

DUNE_VERSION=${DUNE_VERSION:-v10_17_00d00}
DUNE_QUALIFIER=${DUNE_QUALIFIER:-e26:prof}
setup dunesw "$DUNE_VERSION" -q "$DUNE_QUALIFIER"

n=$(wc -l fom_job.args.txt)

srun -n "$n" --gpus-per-task 1 --cpus-per-task 1 fom_job.inner.sh gpu &
srun -n "$n" --cpus-per-task 1 fom_job.inner.sh cpu &

wait
