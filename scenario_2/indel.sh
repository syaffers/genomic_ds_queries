# Get at most 10k variants typed INDEL in chromosome 5
filename='results_indel.txt'

# BCFtools.
echo 'BCFtools' >> $filename
for i in `seq 1 5`
do
    { time /media/shared/tools/bcftools-1.13/bcftools view -H -r chr5 -i 'TYPE="indel"' /media/shared/paper-queries/arab1k.vcf.bgz | head -10000 > /dev/null; } 2>&1 > /dev/null | cut -d '	' -f 2 | head -2 | tail -1 | ../utils/m2s.py >> $filename
done

# GEMINI.
# Ensure that we are in Python 2.7: $ conda activate py27
echo 'GEMINI' >> $filename
for i in `seq 1 5`
do
    { time gemini query --header -q "select * from variants where chrom = 'chr5' and type = 'indel' limit 10000" /media/shared/tools/gemini/153_gemini_pass_normalized.db > /dev/null; } 2>&1 > /dev/null | cut -d '	' -f 2 | head -2 | tail -1 | ../utils/m2s.py >> $filename
done

# Hail.
# Ensure that we are in the hail environment: $ conda activate paper
echo 'Hail' >> $filename
for i in `seq 1 5`
do
	echo $i
	{ time python hail_run_indel.py > /dev/null; } 2>&1 > /dev/null | tail -3 | cut -d '	' -f 2 | head -1 | ../utils/m2s.py >> $filename
done

# SnpSift.
# NOTE: Need to pipe into `head -10232` since headers are included in the output.
# ALSO: Why did we sued the filtered arab1k here? Must be a reason. People are going to notice this.
echo 'SnpSift' >> $filename
for i in `seq 1 5`
do
    { time java -jar /media/shared/tools/snpEff/SnpSift.jar filter "( (CHROM='chr5') & ( VARTYPE = 'DEL' | VARTYPE = 'INS' ) )" /media/shared/paper-queries/arab1k_filtered.vcf | head -10232 > /dev/null; } 2>&1 > /dev/null | tail -3 | cut -d '	' -f 2 | head -1 | ../utils/m2s.py >> $filename
done

# OpenCGA.
# time opencga variant query -s arab1k -r chr5 --type INDEL --limit 10000
for i in `seq 1 5`
do
        { time docker exec -it opencga-rest2 ./opencga.sh variant query -s arab1k -r chr5 --type INDEL --of JSON --limit 10000 > /dev/null; } 2>&1 > /dev/null | cut -d '     ' -f 2 | head -2 | tail -1 | ../utils/m2s.py >> results_opencga_indel.txt
done
