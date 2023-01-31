import hail as hl


mt = hl.read_matrix_table('/media/shared/paper-queries/arab1k.mt')

# Annotate which SNPs are homozygous alternate.
HOM_ALT = hl.agg.all((mt.GT.is_hom_var()) & hl.is_defined(mt.GT))
# HOM_REF = hl.agg.all((mt.GT.is_hom_ref()) & hl.is_defined(mt.GT))

# Filter on the fourth chromosome and for homozygous alternate.
mt_ALT = mt.filter_rows((mt.locus.contig == '4') & HOM_ALT)

# Run filtering.
mt_ALT.GT.show(n_rows = 47, n_cols = 153)
