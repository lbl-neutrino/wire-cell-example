#!/usr/bin/env bash
#SBATCH -q regular -A m5170 -N 1 -C gpu -t 240 --ntasks-per-node=128 --image=fermilab/fnal-wn-sl7

infile=$1; shift

srun --no-kill -K0 shifter --module=cvmfs,gpu ./run_lar_for_fom.baseline.middle.sh "$infile"
