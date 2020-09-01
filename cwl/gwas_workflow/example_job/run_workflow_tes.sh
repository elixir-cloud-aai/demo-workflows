#!/bin/bash

# args: tes remote_storage

tes=${1:-https://csc-tesk-noauth.c03.k8s-popup.csc.fi/}
remote_storage=${2:-ftp://ftp-private.ebi.ac.uk/upload/alex}

cwl-tes \
  --debug \
  --leave-outputs \
  --remote-storage-url $remote_storage \
  --tes $tes \
  ../CWL/gwas_workflow.cwl \
  gwas_test_tes.yaml

