#!/usr/bin/env cwlrunner

class: Workflow

cwlVersion: v1.0

inputs:
  - id: metadata
    type: File
    doc: "all the metadata"
  - id: variants
    type: File
    doc: "to be gwased"

outputs:
  - id: covariates
    type: File
    outputSource: parse_metadata/covariates
  - id: phenotypes
    type: File
    outputSource: parse_metadata/phenotypes
  - id: sex
    type: File
    outputSource: parse_metadata/sex
  - id: ids
    type: File
    outputSource: parse_metadata/ids
  - id: logistic
    type: File
    outputSource: run_gwas/logistic
  - id: manhattan_plot
    type: File
    outputSource: create_plot/manhattan_plot

steps:
  - id: parse_metadata
    run: parse_metadata.cwl
    in:
      - { id: metadata, source: metadata }
    out:
      - { id: covariates }
      - { id: phenotypes }
      - { id: sex }
      - { id: ids }
  - id: run_gwas
    run: run_gwas.cwl
    in:
      - { id: variants, source: variants }
      - { id: ids, source: parse_metadata/ids }
      - { id: sex, source: parse_metadata/sex }
      - { id: phenotypes, source: parse_metadata/phenotypes }
      - { id: covariates, source: parse_metadata/covariates }
    out:
      - { id: logistic }
  - id: create_plot
    run: create_plot.cwl
    in:
      - { id: logistic, source: run_gwas/logistic }
    out:
      - { id: manhattan_plot }
