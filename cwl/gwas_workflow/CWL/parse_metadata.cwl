#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

doc: "parse metadata"

hints:
  - class: DockerRequirement
    dockerPull: dnastack/plink:1.9

  - class: ResourceRequirement
    coresMin: 1
    ramMin: 4
    outdirMin: 10

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