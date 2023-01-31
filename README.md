# Queries for the paper "Benchmarking on-premise approaches for to Genomics Data Science: A Review"

This repository contains the commands used to perform all the queries featured in the paper.

## Requirements

- [BCFtools v1.13](https://github.com/samtools/bcftools)
- [SnpSift v??](https://github.com/). Depends on:
    - Java 1.8.0
- [GEMINI](https://whatever.com). Depends on:
    - Python 2.7.15
- [Hail](https://hail.is/), which requires:
    - Python 3.7.12
- [OpenCGA v2.1.0](https://opencb.org)

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
    - (TBD)
    - Hail annotation code.
4. Gemini
    - `scenario_4/sql_generator.py` for SQLite column generation.
    - `scenario_4/run_gemini.sh` for queries.
5. OpenCGA
    - `scenario_4/run_opencga.sh`.
    - should we include operations?
