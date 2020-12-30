FROM julia:1.5
MAINTAINER Owen Lynch <root@owenlynch.org>

RUN apt-get update && apt-get install texlive-full graphviz -y

RUN apt-get update && apt-get install at-spi2-core libgtk-3-dev xauth xvfb libqt5widgets5 -y

RUN apt-get update && apt-get install build-essential ffmpeg -y

ENV PATH=/root/.julia/conda/3/bin:$PATH

