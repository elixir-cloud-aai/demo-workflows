# ELIXIR Cloud & AAI demo workflows

> [!WARNING]
> This repository is **retired**: it is kept for the record only and is not
> maintained. Its workflows and run scripts were last changed in 2022; the
> run scripts point to TES services and FTP servers that no longer exist, and
> to a fork of `cwl-tes` from 2020. The workflow files may still serve as
> examples, but they are not tested against the current products. See the
> [Demos page](https://docs.elixir-on.cloud/en/latest/demos/#retired-demos)
> of the Documentation Hub for details and for the current demos.

[![License][badge-license]][badge-url-license]

## Synopsis

Collection of workflows used for testing and demonstrating the [ELIXIR Cloud &
AAI][org-elixir-cloud] stack.

## Table of contents

* [GWAS workflow](gwas_workflow)
  * [CWL](gwas_workflow/cwl)
  * [Snakemake](gwas_workflow/smk)
* [Hashsplitter workflow](hashsplitter_workflow)
  * [CWL](hashsplitter_workflow/cwl/README.md)
* [MSA compare workflow](msa_compare_workflow)
  * [CWL](msa_compare_workflow/cwl/README.md)
* [Rare diseases workflow](rare_diseases_workflow)
  * [CWL](rare_diseases_workflow/cwl/README.md)

## Contributing

This repository is retired and no longer takes contributions. To propose a
demo or report one that no longer works, see the
[Demos page](https://docs.elixir-on.cloud/en/latest/demos/#add-a-demo). For
contributions to ELIXIR Cloud & AAI in general, refer to our organization's
[contributing guidelines][res-elixir-cloud-contributing].
Please mind the [code of conduct][res-elixir-cloud-coc] for all interactions
with the community.

## Versioning

Each workflow adopts the [semantic versioning][res-semver] scheme for
versioning.

## License

This project is covered by the [Apache License 2.0][license-apache] also
[shipped with this repository][license].

## Contact

The project is a collaborative effort under the umbrella of [ELIXIR Cloud &
AAI][org-elixir-cloud]. Follow the link to get in touch with us via chat or
email. Please mention the name and URL of the workflow for any inquiry,
proposal, question etc.

[badge-license]:<https://img.shields.io/badge/license-Apache%202.0-blue.svg>
[badge-url-license]:<http://www.apache.org/licenses/LICENSE-2.0>
[license]: LICENSE
[license-apache]: <https://www.apache.org/licenses/LICENSE-2.0>
[org-elixir-cloud]: <https://github.com/elixir-cloud-aai/elixir-cloud-aai>
[res-cwl]: <https://www.commonwl.org/>
[res-elixir-cloud-coc]: <https://github.com/elixir-cloud-aai/elixir-cloud-aai/blob/dev/CODE_OF_CONDUCT.md>
[res-elixir-cloud-contributing]: <https://github.com/elixir-cloud-aai/elixir-cloud-aai/blob/dev/CONTRIBUTING.md>
[res-semver]: <https://semver.org/>
