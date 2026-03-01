#!/usr/bin/env bash

shifter --image=fermilab/fnal-wn-sl7 --module=cvmfs,gpu fom_job.inner.sh "$@"
