#!/bin/bash

# E.g. /global/cfs/cdirs/m5170/data/prodmarley_nue_flat_cc_dune10kt_1x2x2_20250927T000023Z_gen_004329_supernova_g4_detsim.root
input_file=$1; shift

source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh

DUNE_VERSION=${DUNE_VERSION:-v10_16_00d00}
DUNE_QUALIFIER=${DUNE_QUALIFIER:-e26:prof}
setup dunesw "$DUNE_VERSION" -q "$DUNE_QUALIFIER"

FHICL=${FHICL:-reco_dune10kt_1x2x2_just_tpcsigproc.fcl}
NEVENTS=${NEVENTS:--1}

lar -c $FHICL -n $NEVENTS $input_file
