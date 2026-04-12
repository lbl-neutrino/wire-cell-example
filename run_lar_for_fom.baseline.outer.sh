#!/usr/bin/env bash
#SBATCH -A m5170 -N 1 -C gpu -q regular -t 240
#SBATCH --ntasks-per-node=128
#SBATCH --image=fermilab/fnal-wn-sl7

infile=$1; shift

srun shifter --module=cvmfs,gpu ./run_lar_for_fom.baseline.middle.sh "$infile"
