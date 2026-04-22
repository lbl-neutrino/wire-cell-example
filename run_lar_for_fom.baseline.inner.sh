#!/usr/bin/env bash

infile=$1; shift
model=$1; shift
device=$1; shift
nruns=${1:-1}; shift
nevents=${1:--1}; shift
index=${1:0}; shift

index=$(printf "%05d" "$index")

fhicl=$(realpath "reco_pdvd_tpcsigproc_dnnroi_${model}_${device}.fcl")

key=$(basename "$infile" .hdf5)
mkdir -p "output/$key" "logs/$key" "timing/$key"
outfile=$(realpath "output/$key/$key.$model.$device.$index.RECO.root")
logfile=$(realpath "logs/$key/$key.$model.$device.$index.log")
timefile=$(realpath "timing/$key/$key.$model.$device.$index.time")

for _ in $(seq "$nruns"); do
    tmpdir=$(mktemp -d)
    pushd "$tmpdir" || exit 1
    /usr/bin/time -f "%P %M %E" -a -o "$timefile" \
        lar -c "$fhicl" -n "$nevents" "$infile" -o "$outfile" 2>&1 | tee -a "$logfile"
    popd || exit 1
    rm -rf "$tmpdir"
done
