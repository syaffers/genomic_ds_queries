filename="results_snpsift.txt"

for i in `seq 10 10 100`
do
	echo $i >> $filename
	for j in `seq 1 5`
	do
		{ time SnpSift filter "AF_case < 0.4 & AF_control >= 0.4" VCFs/ukb_cs_${i}k_ann.vcf.gz > /dev/null; } 2>&1 > /dev/null | tail -3 | head -1 | cut -d '	' -f 2 | ../utils/m2s.py >> $filename
	done
done
