import sys

import hail as hl


mt = hl.read_matrix_table('/media/shared/paper-queries/arab1k.mt')

# If there are two arguments in the command, do filtering with chromosome filter.
if len(sys.argv) > 3:
    result = mt.filter_rows((mt.rsid == sys.argv[1]) & (mt.locus.contig == sys.argv[2]))
# Else, filter with rsID only.
else:
    result = mt.filter_rows((mt.rsid == sys.argv[1]))

# Run the filtering.
result.show()
