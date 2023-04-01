import hail as hl


hl.init()

for i in range(10, 101, 10):
    vcf = hl.import_vcf(f'VCFs/ukb_cs_{i}k.vcf.gz', force_bgz=True, reference_genome='GRCh37')
    vcf.write(f'MTs/ukb_cs_{i}k.mt', overwrite=True)


for i in range(10,101,10):
    mt = hl.read_matrix_table(f'MTs/ukb_cs_{i}k.mt')

    with open(f'list_ids/controls_{i}k.txt') as f:
        controls = f.read().splitlines()

    with open(f'list_ids/cases_{i}k.txt') as f:
        patients = f.read().splitlines()

    mt = mt.annotate_cols(
        is_control=hl.literal(set(controls)).contains(mt.s)
    )

    mt = mt.annotate_rows(
        control_AF=hl.agg.filter(
            mt.is_control,
            hl.agg.sum(mt.GT.n_alt_alleles()) / hl.agg.sum((2*hl.is_defined(mt.GT)))
        ),
        patient_AF=hl.agg.filter(
            ~mt.is_control,
            hl.agg.sum(mt.GT.n_alt_alleles()) / hl.agg.sum((2*hl.is_defined(mt.GT)))
        )
    )

    mt.write(f'MTs/ukb_cs_{i}k_ann.mt', overwrite=True)
