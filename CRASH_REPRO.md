# Crash reproduction

## Enter the container

Apptainer example:

```bash
/cvmfs/oasis.opensciencegrid.org/mis/apptainer/current/bin/apptainer shell --nv --shell=/bin/bash -B /cvmfs,/global/cfs,/global/common,/pscratch --ipc --pid /cvmfs/singularity.opensciencegrid.org/fermilab/fnal-dev-sl7:latest
```

Shifter example:

```bash
shifter --image=fermilab/fnal-wn-sl7 --module=cvmfs,gpu -- /bin/bash
```

## Load the stack

```bash
source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh
setup dunesw v10_17_00d00 -q e26:prof
export WIRECELL_PATH=$DUNERECO_DIR/wire-cell-cfg/pgrapher/experiment/protodunevd:$WIRECELL_PATH
```

## Crash!

CP49.ts:

```bash
lar -c reco_pdvd_tpcsigproc_dnnroi_CP49_gpu.fcl /global/cfs/cdirs/m5170/data/fom_inputs/np02vd_raw_run039255_0088_df-s04-d1_dw_0_20250830T114841.hdf5

```

unet-l23-cosmic500-e50.ts:

```bash
lar -c reco_pdvd_tpcsigproc_dnnroi_CP49_unet.fcl /global/cfs/cdirs/m5170/data/fom_inputs/np02vd_raw_run039255_0088_df-s04-d1_dw_0_20250830T114841.hdf5 
```
