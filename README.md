# Queries for the paper "Benchmarking on-premise approaches for to Genomics Data Science: A Review"

This repository contains the commands used to perform all the queries featured in the paper.


## Requirements

- [BCFtools v1.13](https://github.com/samtools/bcftools)
- [SnpSift v5.0e](https://pcingola.github.io/SnpEff/). Depends on:
    - Java 1.8.0
- [GEMINI v0.20.1](https://gemini.readthedocs.io/en/latest/). Depends on:
    - Python 2.7.15
- [Hail v0.2.105-acd89e80c345](https://hail.is/), which requires:
    - Python 3.7.12
    - Apache Spark 3.1.3 (installed with Hail)
- [OpenCGA v2.1.0](https://docs.opencga.opencb.org/)


### Docker image

We have provided a `Dockerfile` which can be built as follows:

```bash
docker build -t gdsq:latest .
```

Building the Docker image can take some time, depending on connection speed and CPU.  We found that it took around 25 minutes to build the Docker image.

To run the image:

```bash
docker run --rm -it gdsq:latest
```

All tools are available *except OpenCGA* as it requires some additional setup that makes it impossible to include in a Docker container. The container starts in the `py3` environment so Hail can be run along with other tools. GEMINI is installed in the `py2` environment but can be used even from the `py3` environment thanks to its alias.


## Scenario 1

The query statement is

>Return all information for a variant given its unique rsID

The related files are:

- `eqd_sampling.tsv`: contains a list of SNPs which are roughly equidistant to one another in the genome. These SNPs are queried for using the following tools:

    1. Bcftools
        - `run_bcftools.sh`
        - `run_bcftools_wchr.sh`
    2. SnpSift
        - `run_snpsift.sh`
        - `run_snpsift_wchr.sh`
    3. Hail
        - `run_hail.sh` (with `hail-run.py`)
        - `run_hail_wchr.sh` (with `hail-run.py`)
    4. Gemini
        - `run_gemini.sh`
        - `run_gemini_wchr.sh`
    5. OpenCGA
        - `run_opencga.sh`
        - `run_opencga_wchr.sh`


## Scenario 2

The query statement is

>Get all variants typed INDEL in chromosome 5

The related files are:

- `indel.sh`
- `hail_run_indel.py`


## Scenario 3

The query statement is

>Retrieve sites where all samples have the homozygous genotype

The related files are:

- `HOM.sh`
- `hail_run_HOM.py`


## Scenario 4

The query statement is

>Retrieve the variants where the allele frequency of patients is below or equal to 40% and the allele frequency of controls is above 40%

The related files are:

1. Bcftools
    - `scenario_4/run_bcftools_ann.sh` for annotation.
    - `scenario_4/run_bcftools.sh` for queries.
2. SnpSift
    - `scenario_4/run_snpsift.sh`.
3. Hail
    - `run_prep_hail.py` to create Matrix Tables.
    - `hail_query.py` to run the query in Hail.
    - `run_hail.sh` to loop through files and
4. Gemini
    - `scenario_4/sql_generator.py` for SQLite column generation.
    - `scenario_4/run_gemini.sh` for queries.
5. OpenCGA
    - `scenario_4/run_prep_opencga.sh`.
    - `scenario_4/run_opencga.sh`.
