class: CommandLineTool
cwlVersion: v1.0
id: picard_create_seq_dict

baseCommand: [ java, -jar, /usr/picard/picard.jar, CreateSequenceDictionary ]
  
requirements:
  - class: InlineJavascriptRequirement
  - class: DockerRequirement
    dockerPull: broadinstitute/picard  
  - class: ResourceRequirement
    outdirMin: 7500
    tmpdirMin: 7700
    coresMin: 2
    ramMin: 8000

inputs:
  - id: reference_genome
    type: File
    inputBinding:
      position: 1
      prefix: 'R='
      separate: false

arguments:
  - position: 2
    prefix: 'O='
    separate: false
    valueFrom: $(inputs.reference_genome.nameroot).dict

outputs:
  - id: dict
    type: File
    outputBinding:
      glob: "*.dict"

 
