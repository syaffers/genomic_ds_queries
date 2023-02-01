# Create a project.
opencga projects create --id ukb --name UKBiobank --organism-scientific-name hsapiens --organism-assembly GRCH37

# Create a study.
opencga studies create --id cs10k --name CS10K --project ukb

##
# Uploading the VCF file, Indexing and running queries:
#

# Copy the vcf file from host to vm (has to be sessions folder):
scp <vcf file location> master-vm:/opt/opencga/sessions
opencga files tree -s cs10k
opencga files create --path data --study cs10k
# To see the folder: opencga files tree -s cs10k

# Link the vcf file:
opencga files link-run --input /opt/opencga/sessions/ukb_cs_10k_ann.vcf.gz -s ukb:cs10k --path data/

# Run the indexing and administration operations.
opencga variant index-run --file data
opencga jobs top (to get the index-job-id)
opencga jobs log -s ukb:cs10k -f
opencga operations variant-annotation-index --project ukb --job-depends-on <index-job-id>
opencga variant stats-run --study cs10k --job-depends-on <index-job-id> --index --cohort ALL

# Create cohorts.
opencga cohorts create -n cases -s ukb:cs10k --samples `cat cases_10k_sampleLine.txt`
opencga cohorts create -n controls -s ukb:cs10k --samples `cat controls_10k_sampleLine.txt`

# Calculate variant statistics.
opencga operations variant-stats-index --study ukb:cs10k --cohort cases
opencga operations variant-stats-index --study ukb:cs10k --cohort controls
