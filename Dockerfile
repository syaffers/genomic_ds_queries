FROM continuumio/miniconda3:22.11.1

WORKDIR /app

COPY . .

RUN conda create -n py3 -c conda-forge -c bioconda python=3.7.12 snpsift=5.1 bcftools=1.13 -y
SHELL ["conda", "run", "-n", "py3", "/bin/bash", "-c"]
RUN pip install -r requirements.py3.txt

RUN conda create -n py2 -c conda-forge -c bioconda python=2.7.15 gemini=0.20.1 -y

RUN echo 'alias bcftools=/opt/conda/envs/py3/bin/bcftools' >> /root/.bashrc
RUN echo 'alias SnpSift=/opt/conda/envs/py3/share/snpsift-5.1-0/SnpSift' >> /root/.bashrc
RUN echo 'alias gemini=/opt/conda/envs/py2/bin/gemini' >> /root/.bashrc
RUN echo 'conda activate py3' >> /root/.bashrc

CMD ["bash"]
