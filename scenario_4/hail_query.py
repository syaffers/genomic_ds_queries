import sys

import hail as hl


mt = hl.read_matrix_table(f'/media/shared/ukb-cs/MTs/ukb_cs_{sys.argv[1]}k_ann.mt')

total = mt.filter_rows((mt.control_AF >= 0.4) & (mt.patient_AF < 0.4)).count_rows()
total
