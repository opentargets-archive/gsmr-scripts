GSMR Support Scripts
==================================

#### Requirements

- anaconda 3
- [GCTA - Linux](https://cnsgenomics.com/software/gcta/bin/gcta_1.93.2beta.zip)

```sh
# Download
git clone https://github.com/opentargets/gsmr-scripts.git
cd gsmr-scripts

# Install dependencies into isolated environment
conda-env create -n gsmr-scripts -f environment.yaml

# Activate environment
conda activate gsmr-scripts

# deactivate
conda deactivate

# delete de environment
conda-env remove -n gsmr-scripts

```
