#get all variants where all samples have homozygous genotype
filename='results_HOM.txt'

# BCFtools.
echo 'BCFtools' >> $filename
for i in `seq 1 5`
do
    { time /media/shared/tools/bcftools-1.13/bcftools view -H -r 'chr4' -i 'COUNT(GT="AA")=153' /media/shared/paper-queries/arab1k.vcf.bgz > /dev/null; } 2>&1 > /dev/null | cut -d '	' -f 2 | head -2 | tail -1 | ../utils/m2s.py >> $filename
done

# GEMINI.
# Ensure that we are in Python 2.7: $ conda activate py27
echo 'GEMINI' >> $filename
for i in `seq 1 5`
do
    { time gemini query -q "SELECT * FROM variants WHERE chrom='chr4'" --gt-filter "(gt_types).(*).(==HOM_ALT).(all)" /media/shared/tools/gemini/153_gemini_pass_normalized.db > /dev/null; } 2>&1 > /dev/null | tail -3 | cut -d '	' -f 2 | head -1 | ../utils/m2s.py >> $filename
done

# GEMINI with `bcolz`.
# Ensure that we are in Python 2.7: $ conda activate py27
echo 'GEMINI-bcolz' >> $filename
for i in `seq 1 5`
do
    { time gemini query -q "SELECT * FROM variants WHERE chrom='chr4'" --gt-filter "(gt_types).(*).(==HOM_ALT).(all)" --use-bcolz /media/shared/tools/gemini/153_gemini_pass_normalized.db > /dev/null; } 2>&1 > /dev/null | tail -3 | cut -d '	' -f 2 | head -1 | ../utils/m2s.py >> $filename
done

# Hail.
# Ensure that we are in the hail environment: $ conda activate paper
echo 'Hail' >> $filename
for i in `seq 1 5`
do
    { time python hail_run_HOM.py > /dev/null; } 2>&1 > /dev/null | tail -3 | cut -d '	' -f 2 | head -1 | ../utils/m2s.py >> $filename
done

# SnpSift
echo 'SnpSift' >> $filename
for i in `seq 1 5`
do
    { time java -jar /media/shared/tools/snpEff/SnpSift.jar filter "( CHROM = 'chr4' ) && ( countVariant() = 153 ) && ( countHet() = 0 )" /media/shared/paper-queries/arab1k_filtered.vcf | head -10232 > /dev/null; } 2>&1 > /dev/null | tail -3 | cut -d '	' -f 2 | head -1 | ../utils/m2s.py >> $filename
done

# OpenCGA.
filename="results_opencga_HOM.txt"
echo "OpenCGA" >> $filename
for i in `seq 1 100`
do
        { time docker exec -it opencga-rest2 ./opencga.sh variant query -s arab1k -r chr4 --gt "10174:HOM_ALT;10187:HOM_ALT;10205:HOM_ALT;10215:HOM_ALT;10227:HOM_ALT;10231:HOM_ALT;10249:HOM_ALT;10347:HOM_ALT;10411:HOM_ALT;10490:HOM_ALT;10556:HOM_ALT;10651:HOM_ALT;10698:HOM_ALT;10708:HOM_ALT;10725:HOM_ALT;10735:HOM_ALT;10737:HOM_ALT;10745:HOM_ALT;10779:HOM_ALT;10792:HOM_ALT;10853:HOM_ALT;10863:HOM_ALT;10865:HOM_ALT;10878:HOM_ALT;10885:HOM_ALT;10888:HOM_ALT;10925:HOM_ALT;10926:HOM_ALT;10930:HOM_ALT;120008:HOM_ALT;120009:HOM_ALT;120013:HOM_ALT;120035:HOM_ALT;120057:HOM_ALT;120060:HOM_ALT;120067:HOM_ALT;120069:HOM_ALT;120071:HOM_ALT;120075:HOM_ALT;120081:HOM_ALT;120089:HOM_ALT;120113:HOM_ALT;120118:HOM_ALT;120129:HOM_ALT;120131:HOM_ALT;120133:HOM_ALT;120136:HOM_ALT;120145:HOM_ALT;120147:HOM_ALT;120148:HOM_ALT;120157:HOM_ALT;120164:HOM_ALT;120165:HOM_ALT;120190:HOM_ALT;120195:HOM_ALT;120197:HOM_ALT;120200:HOM_ALT;120206:HOM_ALT;120213:HOM_ALT;120217:HOM_ALT;120227:HOM_ALT;120246:HOM_ALT;120287:HOM_ALT;120324:HOM_ALT;120326:HOM_ALT;120349:HOM_ALT;120351:HOM_ALT;120364:HOM_ALT;120396:HOM_ALT;120403:HOM_ALT;120407:HOM_ALT;120472:HOM_ALT;120506:HOM_ALT;120535:HOM_ALT;120538:HOM_ALT;120539:HOM_ALT;120541:HOM_ALT;12553:HOM_ALT;12560:HOM_ALT;12567:HOM_ALT;12584:HOM_ALT;12590:HOM_ALT;12595:HOM_ALT;12608:HOM_ALT;12636:HOM_ALT;12638:HOM_ALT;12654:HOM_ALT;12657:HOM_ALT;12674:HOM_ALT;12718:HOM_ALT;12730:HOM_ALT;12742:HOM_ALT;12750:HOM_ALT;12754:HOM_ALT;12804:HOM_ALT;12813:HOM_ALT;12820:HOM_ALT;12825:HOM_ALT;12850:HOM_ALT;12859:HOM_ALT;12868:HOM_ALT;12869:HOM_ALT;12872:HOM_ALT;12878:HOM_ALT;12900:HOM_ALT;12907:HOM_ALT;12909:HOM_ALT;12912:HOM_ALT;12930:HOM_ALT;12936:HOM_ALT;12940:HOM_ALT;12960:HOM_ALT;12964:HOM_ALT;12966:HOM_ALT;12973:HOM_ALT;12975:HOM_ALT;12984:HOM_ALT;12991:HOM_ALT;12994:HOM_ALT;13024:HOM_ALT;13042:HOM_ALT;13049:HOM_ALT;13071:HOM_ALT;13076:HOM_ALT;13080:HOM_ALT;13084:HOM_ALT;13098:HOM_ALT;13116:HOM_ALT;13119:HOM_ALT;13120:HOM_ALT;13124:HOM_ALT;13125:HOM_ALT;13137:HOM_ALT;13149:HOM_ALT;13157:HOM_ALT;13164:HOM_ALT;13176:HOM_ALT;13177:HOM_ALT;13223:HOM_ALT;13381:HOM_ALT;13503:HOM_ALT;13508:HOM_ALT;13525:HOM_ALT;13526:HOM_ALT;13529:HOM_ALT;13535:HOM_ALT;13541:HOM_ALT;13544:HOM_ALT;13554:HOM_ALT;13559:HOM_ALT;13563:HOM_ALT;13588:HOM_ALT;13590:HOM_ALT" --of JSON > /dev/null; } 2>&1 > /dev/null | tail -3 | head -1 | cut -d '     ' -f 2 | ../utils/m2s.py >> $filename
done
