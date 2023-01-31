import hail as hl


mt = hl.read_matrix_table('/media/shared/paper-queries/arab1k.mt')

# Annotate which SNPs are indels.
mt = mt.annotate_rows(
    info=mt.info.annotate(
        is_indel=hl.any(hl.map(lambda a: hl.is_indel(mt.alleles[0], a), mt.alleles[1:]))))

# Run filtering.
mt.filter_rows((mt.info.is_indel == True) & (mt.locus.contig == '5')).show(10000)
