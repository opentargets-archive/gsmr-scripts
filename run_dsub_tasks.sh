#!/bin/bash

# gs://genetics-portal-analysis/mohd/gcta/gcta64 

# ref panel gs://genetics-portal-analysis/mohg/dsub-test/UK10K_ref_panel/
# proteins gs://genetics-portal-analysis/mohd/dsub-test/SUN2018_full_harmonised_gsmr_v2/
# outcomes gs://genetics-portal-analysis/mohd/dsub-test/outcomes-gsmr-formatted/

# image debian-10

export GOOGLE_APPLICATION_CREDENTIALS="tmp/open-targets-genetics-fc5b6cda58e5.json"

project=open-targets-genetics
bucket="gs://genetics-portal-analysis/mohd/dsub-test"
logs_dir="${bucket}/logs"
ref_dir="${bucket}/UK10K_ref_panel"
proteins_dir="${bucket}/SUN2018_full_harmonised_gsmr_v2"
outcomes_dir="${bucket}/outcomes-gsmr-formatted"
out_dir="${bucket}/output"
bucket_mount="gs://genetics-portal-analysis"

gcta="gs://genetics-portal-analysis/mohd/gcta/gcta64"

dsub \
    --provider google-cls-v2 \
    --project $project \
    --regions europe-west1 \
    --logging $logs_dir \
    --boot-disk-size 500 \
    --timeout '7d' \
    --machine-type n1-highmem-4 \
    --image gcr.io/cloud-marketplace/google/debian10 \
    --script process_gcta_tasks.sh \
    --credentials-file tmp/open-targets-genetics-fc5b6cda58e5.json \
    --tasks tasks.tsv \
    --wait
