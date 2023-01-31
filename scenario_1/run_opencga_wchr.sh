filename="results_opencga_wchr.txt"

# Loop through all the selected SNPs in eqd_sampling.tsv.
for line in `tail -n +2 eqd_sampling.tsv | cut -d '	' -f 1,3 | sed 's/\t/,/'`
do
    # Read the values for chromosome number and position in eqd_sampling.tsv.
    IFS=','
    read -r chr rs <<< "$line"

    # Write into file to indicate current SNP.
    echo $rs >> $filename

    # Query and write query time into file.
    { time docker exec -it opencga-rest2 ./opencga.sh variant query -s arab1k -r "$chr" --id $rs --of JSON > /dev/null; } 2>&1 > /dev/null | tail -3 | cut -d '	' -f 2 | head -2 | tail -1 | ../utils/m2s.py >> $filename

    # Reset so that terminal works as usual again.
    IFS='	'
done
