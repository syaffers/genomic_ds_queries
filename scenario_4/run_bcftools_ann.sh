filename="resultsCS_bcftools_ann.txt"

for i in `seq 10 10 100`
do
	echo "${i}k" >> $filename
        { time bcftools +fill-tags VCFs/ukb_cs_${i}k.vcf.gz -Oz -o VCFs/ukb_cs_${i}k_ann.vcf.gz -- -S list_ids/ukb_${i}k.txt -t AF > /dev/null; } 2>&1 > /dev/null | tail -3 | head -1 | cut -d '	' -f 2 | ../utils/m2s.py >> $filename

done
