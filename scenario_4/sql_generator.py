#alt_table = """
#ALTER TABLE variants ADD control_AF real;
#ALTER TABLE variants ADD case_AF real;
#""".strip()

insert_query = """
WITH Tmp(id, control_af, case_af) AS (VALUES{})
UPDATE variants SET control_AF = (SELECT control_af FROM Tmp WHERE variants.vcf_id = Tmp.id), case_AF = (SELECT case_af FROM Tmp WHERE variants.vcf_id = Tmp.id)
WHERE vcf_id IN (SELECT id FROM Tmp);
""".strip()

rows = []
counter = 0
file_counter = 0
with open('values20k', 'r') as f:
	for line in f.readlines():
		rows.append("({})".format(line.strip()))
		counter += 1

		if counter == int(1024):
			values_str = ",".join(rows)
			with open('insert_query_{}.sql'.format(file_counter), 'w') as g:
				g.write(insert_query.format(values_str) + '\n')
			counter = 0
			file_counter += 1
			rows = []

values_str = ",".join(rows)
with open('insert_query_{}.sql'.format(file_counter), 'w') as g:
	g.write(insert_query.format(values_str) + '\n')
