filename="results_gemini.txt"

for x in `seq 1 5`
do
	echo $x >> $filename
	for i in `seq 10 10 30`
	do
		echo $i
		{ time gemini query --header -q "SELECT count(*) FROM variants WHERE control_AF >= 0.4 AND case_AF < 0.4 " gemini_dbs/ukb_cs_${i}k.db > /dev/null; } 2>&1 > /dev/null | tail -3 | head -1 | cut -d '	' -f 2 | ../utils/m2s.py >> $filename
	done
done
