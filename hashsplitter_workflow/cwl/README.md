# Hashsplitter workflow

Computes different hash sums of a file and collates the results.

## Overview

- Main workflow file: `hashsplitter-workflow.cwl`
- Parameter file: `hashsplitter-test.yml`

## Test

Execution with [cwl-tes][res-cwl-tes]:

> NOTE: Requires a [GA4GH TES][res-ga4gh-tes] implementation to be set up.

```bash
bash run_example_tesk.sh
```

[res-cwl-tes]: <https://github.com/ohsu-comp-bio/cwl-tes>
[res-ga4gh-tes]: <https://github.com/ga4gh/task-execution-schemas>
