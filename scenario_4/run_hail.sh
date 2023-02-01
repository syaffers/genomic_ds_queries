filename="results_hail.txt"

for line in `seq 10 10 100`
do
    echo $line >> $filename
    for i in `seq 1 5`
    do
        { time python hail_query.py $line > /dev/null; } 2>&1 > /dev/null | tail -3 | cut -d '	' -f 2 | head -1 | ../utils/m2s.py >> $filename
    done
done
