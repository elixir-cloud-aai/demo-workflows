#!/bin/bash

snakemake \
    --configfile=gwas_test.yaml --cores 1 \
    --use-singularity --snakefile="../Snakefile"
