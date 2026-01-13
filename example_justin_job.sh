#!/bin/bash

# Required env:
# - METADATA_TAR
# - MODULE_TAR
# - FHICL
# - CAMPAIGN_META
# - NEVENTS

source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh

stat $METADATA_TAR >&/dev/null
if [ $? -ne 0 ]; then
  echo "metadata.tar not found"
  exit 1
fi

DUNE_VERSION=${DUNE_VERSION:-v10_11_00d00}
DUNE_QUALIFIER=${DUNE_QUALIFIER:-e26:prof}
setup dunesw "$DUNE_VERSION" -q "$DUNE_QUALIFIER"
if [ $? -ne 0 ]; then
  echo "setup dunesw $DUNE_VERSION -q $DUNE_QUALIFIER failed"
  exit 1
fi

export PROTODUNEANA_DIR=${MODULE_TAR}/${DUNE_VERSION}
export PROTODUNEANA_INC=${PROTODUNEANA_DIR}/include
export PROTODUNEANA_FQ_DIR=${PROTODUNEANA_DIR}/slf7.x86_64.e26.prof
export PROTODUNEANA_LIB=${PROTODUNEANA_FQ_DIR}/lib
export CET_PLUGIN_PATH=$PROTODUNEANA_LIB:$CET_PLUGIN_PATH
export FW_SEARCH_PATH=${MODULE_TAR}:$FW_SEARCH_PATH

export FHICL_FILE_PATH=${METADATA_TAR}:${FHICL_FILE_PATH}

input_file=$($JUSTIN_PATH/justin-get-file | cut -f2 -d ' ')
if [ -z "$input_file" ]; then
  echo "justin-get-file failed"
  exit 1
fi
nev=${NEVENTS:--1}

start_time=$(date +"%s").0
lar -c $FHICL -n $nev $input_file
if [ $? -ne 0 ]; then exit $?; fi
end_time=$(date +"%s").0
output_file=$(ls *.root)

setup metacat
export METACAT_SERVER_URL=https://metacat.fnal.gov:9443/dune_meta_prod/app
export METACAT_AUTH_SERVER_URL=https://metacat.fnal.gov:8143/auth/dune

python -m meta_maker \
  --start_time $start_time --end_time $end_time --file_format "root" \
  --app_family "dunesw" --app_name "reco" --app_version ${DUNE_VERSION} \
  --data_tier "root-tuple-virtual"\
  --campaign "$CAMPAIGN_META" \
  --fcl $FHICL \
  -f "${JUSTIN_SCOPE}:$output_file" -j "${output_file}.json"
if [ $? -ne 0 ]; then
  echo "meta_maker.py failed"
  exit $?
fi

echo "$input_file" > processed_files.list
