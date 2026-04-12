#!/usr/bin/env bash

infile=$1; shift
model=$1; shift
device=$1; shift
nruns=${1:-1}; shift
index=${1:0}; shift

index=$(printf "%05d" "$index")

fhicl=reco_pdvd_tpcsigproc_dnnroi_${model}_${device}.fcl

key=$(basename "$infile" .hdf5)
mkdir -p "output/$key" "logs/$key" "timing/$key"
outfile=output/$key/$key.$model.$device.$index.RECO.root
logfile=logs/$key/$key.$model.$device.$index.log
timefile=timing/$key/$key.$model.$device.$index.time

for _ in $(seq $nruns); do
    rm -f "$outfile"
    /usr/bin/time -f "%P %M %E" -a -o "$timefile" \
        lar -c "$fhicl" "$infile" -o "$outfile" 2>&1 | tee -a "$logfile"
done
