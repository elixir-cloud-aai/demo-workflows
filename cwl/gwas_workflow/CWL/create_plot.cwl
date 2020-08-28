#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

doc: "create manhattan plot"

hints:
  - class: DockerRequirement
    dockerPull: gwas_with_cwl:v1

  - class: ResourceRequirement
    coresMin: 2
    ramMin: 8
    outdirMin: 20

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
