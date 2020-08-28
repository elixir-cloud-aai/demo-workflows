#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

doc: "run plink on vcf file"

hints:
  - class: DockerRequirement
    dockerPull: dnastack/plink:1.9

  - class: ResourceRequirement
    coresMin: 1
    ramMin: 4
    outdirMin: 10

requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: run_gwas.sh
        entry: |-
          output_basename=\$(basename $1 .vcf.gz)
          plink --vcf $1 --maf 0.10 --update-ids $2 --make-bed --out $output_basename
          plink --bfile $output_basename --update-sex $3 --pheno $4 --make-bed --out $output_basename
          plink --bfile $output_basename --covar $5 --dummy-coding --write-covar
          plink --bfile $output_basename --logistic --covar plink.cov --out $output_basename
          sed -i -e "s/\\s\\+/,/g" -e "s/^,//g" -e "s/,\$//g" \${output_basename}.assoc.logistic

inputs:
  - id: variants
    type: File
    inputBinding:
      position: 1
  - id: ids
    type: File
    inputBinding:
      position: 2
  - id: sex
    type: File
    inputBinding:
      position: 3
  - id: phenotypes
    type: File
    inputBinding:
      position: 4
  - id: covariates
    type: File
    inputBinding:
      position: 5

outputs:
  - id: logistic
    type: File
    outputBinding:
      glob: "*.assoc.logistic"

baseCommand: ["sh", "run_gwas.sh"]