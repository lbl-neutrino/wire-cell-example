#!/usr/bin/env bash

# shifter --image=fermilab/fnal-wn-sl7 --module=cvmfs,gpu -- ./fom_job.inner.sh "$@"

/cvmfs/oasis.opensciencegrid.org/mis/apptainer/current/bin/apptainer exec --nv -B /cvmfs,/global/cfs,/global/common,/pscratch --ipc --pid /cvmfs/singularity.opensciencegrid.org/fermilab/fnal-dev-sl7:latest /bin/bash fom_job.inner.sh "$@"
