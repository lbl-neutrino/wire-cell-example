#!/bin/bash

# E.g. [1] /global/cfs/cdirs/m5170/data/prodmarley_nue_flat_cc_dune10kt_1x2x2_20250927T000023Z_gen_004329_supernova_g4_detsim.root
# or   [2] /global/cfs/cdirs/m5170/data/np02vd_raw_run042250_0000_df-s04-d0_dw_0_20260123T125257.hdf5
input_file=$1; shift

source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh

DUNE_VERSION=${DUNE_VERSION:-v10_17_00d00}
DUNE_QUALIFIER=${DUNE_QUALIFIER:-e26:prof}
setup dunesw "$DUNE_VERSION" -q "$DUNE_QUALIFIER"

FHICL=${FHICL:-reco_dune10kt_1x2x2_just_tpcsigproc.fcl} # [1]
#FHICL=${FHICL:-reco_pdvd_tpcsigproc.fcl} # [2]
NEVENTS=${NEVENTS:--1}

lar -c $FHICL -n $NEVENTS $input_file
