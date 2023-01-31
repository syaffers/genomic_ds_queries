filename="opencga_results.txt"

echo cs10k >> $filename
for i in `seq 1 5`
do
        { time docker exec -it opencga-rest3 ./opencga.sh variant query --study ukb:cs10k --cohort-stats-ref "cs10k:cases<=0.4;cs10k:controls>0.4" --limit 30 --of JSON > /dev/null; } 2>&1 > /dev/null | tail -3 | head -1 | cut -d '	' -f 2 | ../utils/m2s.py >> $filename
done

echo ccs20k >> $filename
for i in `seq 1 5`
do
        { time docker exec -it opencga-rest3 ./opencga.sh variant query --study ukb:ccs20k --cohort-stats-ref "ccs20k:cases<=0.4;ccs20k:controls>0.4" --limit 30 --of JSON > /dev/null; } 2>&1 > /dev/null | tail -3 | head -1 | cut -d '	' -f 2 | ../utils/m2s.py >> $filename
done
