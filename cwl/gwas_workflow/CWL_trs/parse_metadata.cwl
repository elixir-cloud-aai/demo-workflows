#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

doc: "parse metadata"

hints:
  - class: DockerRequirement
    dockerPull: trs://api.biocontainers.pro/gwas-fasp/versions/gwas-fasp-vv1.0.0

  - class: ResourceRequirement
    coresMin: 1
    ramMin: 1024
    outdirMin: 1024

inputs:
  - id: metadata
    type: File
    doc: "original content"
    inputBinding:
      position: 1

outputs:
  - id: covariates
    type: File
    outputBinding:
      glob: "covariates.txt"
  - id: phenotypes
    type: File
    outputBinding:
      glob: "phenotypes.txt"
  - id: sex
    type: File
    outputBinding:
      glob: "sex.txt"
  - id: ids
    type: File
    outputBinding:
      glob: "ids.txt"

baseCommand: ["parse_metadata.sh"]

arguments: ["-c"]
