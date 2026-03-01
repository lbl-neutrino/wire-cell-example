#!/usr/bin/env bash

NRUNS=2

device=$1; shift     # cpu or gpu

# get corresponding line of fom_job.args.txt
lineno=$((SLURM_PROCID + 1))
args=$(sed -n ${lineno}p fom_job.args.txt)
read -ra args <<< "$args"       # split into array

infile=${args[0]}
model=${args[1]}

fhicl=reco_pdvd_tpcsigproc_dnnroi_${model}_${device}.fcl

mkdir -p output timing
outfile=output/$(basename "$infile" .hdf5).$model.$device.RECO.root
timefile=timing/$(basename "$infile" .hdf5).$model.$device.time

for _ in $(seq $NRUNS); do
    rm -f "$outfile"
    /usr/bin/time -f "%P %M %E" -a -o "$timefile" \
        lar -c "$fhicl" "$infile" -o "$outfile"
done
