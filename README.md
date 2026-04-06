# Scripts for benchmarking Wire-Cell at NERSC

This repository contains NERSC-specific scripts, config files, etc., for running [Wire-Cell](https://github.com/WireCell/wire-cell-toolkit) as part of the LArSoft-based DUNE software stack. The main motivation for this, currently, is to enable performance studies at NERSC of Wire-Cell's DNNROI algorithm (Deep Neural Network Region-Of-Interest finding) on both CPU and GPU hardware. As Wire-Cell's algorithms (and their hardware requirements) continue to evolve, so will this repository.

## Obtaining a baseline performance Figure of Merit (FOM)

The following instructions describe how to run a minimal LArSoft job that calls Wire-Cell after decoding the raw data from the ProtoDUNE Vertical Drift detector.

### Getting a compute node

First, obtain a CPU node:

``` bash
salloc -N 1 -q interactive -C cpu -t 240
```

### Entering the container

Then, enter DUNE's Scientific Linux 7 container. (Eventually we will switch to a modern AlmaLinux 9 container.) For example, using Apptainer:

``` bash
/cvmfs/oasis.opensciencegrid.org/mis/apptainer/current/bin/apptainer shell --nv --shell=/bin/bash -B /cvmfs,/global/cfs,/global/common,/pscratch --ipc --pid /cvmfs/singularity.opensciencegrid.org/fermilab/fnal-dev-sl7:latest
```

Or Shifter:

``` bash
shifter --image=fermilab/fnal-wn-sl7 --module=cvmfs,gpu -- /bin/bash
```

Or podman-hpc:

``` bash
podman-hpc run --rm -it --gpu --nccl-cu12 -v /cvmfs:/cvmfs -v /global/cfs:/global/cfs -v /global/common:/global/common -v /pscratch:/pscratch -v "$PWD":"$PWD" -w "$PWD" docker.io/fermilab/fnal-dev-sl7:latest bash
```

### Running the benchmark

Now simply run the script:

``` bash
./run_lar_for_fom.baseline.sh && exit
```

This will run a minimal LArSoft/Wire-Cell workflow on two ProtoDUNE VD files sequentially (one containing 8 GeV/c beam data, the other containing just cosmic rays). Each file is processed 3 times in a row to confirm that there's minimal variance in run time. (This can be changed by altering the `nruns` variable in the script.)

### Extracting the FOM

After the script has been run, three new directories should exist: `output`, `logs`, and `timing`. The `timing` directory contains one `foo.time` file for each ProtoDUNE input file. In each such file there will be one line for each of the 3 runs, containing the peak CPU usage, peak memory usage, and wall time. This last quantity serves as our FOM.
