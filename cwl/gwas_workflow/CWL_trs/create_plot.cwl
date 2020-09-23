#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

doc: "create manhattan plot"

hints:
  - class: DockerRequirement
    dockerPull: biocontainers/gwas-fasp:vv1.0.0_cv1

  - class: ResourceRequirement
    coresMin: 2
    ramMin: 1024
    outdirMin: 1024

inputs:
  - id: logistic
    type: File
    inputBinding:
      position: 1

outputs:
  - id: manhattan_plot
    type: File
    outputBinding:
      glob: "*.png"

baseCommand: ["create_plot.sh"]
