#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

doc: "create manhattan plot"

hints:
  - class: DockerRequirement
    dockerPull: dnastack/plink:1.9
  - class: ResourceRequirement
    coresMin: 2
    ramMin: 8
    outdirMin: 20

requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: create_plot.sh
        entry: |-
          output_basename=\$(basename $1 .assoc.logistic)
          chromosome=\$(head -2 $1 | tail -1 | cut -d "," -f 1)
          manhattan_plot.py -i $1 -o $output_basename.png -c $chromosome

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

baseCommand: ["sh", "create_plot.sh"]
