#To build;
# docker build -t awkwarddoc1 .
# to run;
# docker run -ti awkwarddoc1

# base image
FROM ubuntu:20.04

# some meta data
LABEL version=1.0
LABEL description="A docker container to reproduce an awkward issue (haha)"
LABEL author="Henry Day-Hall"

# install packages
RUN apt-get update && \
    apt-get -y install python3 python3-pip vim-tiny nano
RUN echo "alias vim=vim.tiny" >> ~/.bashrc

RUN  pip3 install --upgrade pip

RUN pip3 install awkward==1.2.2
RUN pip3 install pyarrow

RUN echo "import awkward as ak" >> ~/problem.py && \
    echo "import numpy as np" >> ~/problem.py && \
    echo "print(f'Awkward version {ak.__version__}')" >> ~/problem.py && \
    echo "dog = ak.from_iter([1, 2, 3])[np.newaxis]" >> ~/problem.py && \
    echo "pets = {'dog': dog}" >> ~/problem.py && \
    echo "zipped = ak.zip(pets, depth_limit=1)" >> ~/problem.py && \
    echo "ak.to_parquet(zipped, 'test.parquet')" >> ~/problem.py && \
    echo "print('Save success')" >> ~/problem.py && \
    echo "dog = ak.from_iter([True, False, True])[np.newaxis]" >> ~/problem.py && \
    echo "pets = {'dog': dog}" >> ~/problem.py && \
    echo "zipped = ak.zip(pets, depth_limit=1)" >> ~/problem.py && \
    echo "ak.to_parquet(zipped, 'test.parquet')" >> ~/problem.py

RUN echo "echo 'Please run python3 ~/problem.py'" >> ~/.bashrc
