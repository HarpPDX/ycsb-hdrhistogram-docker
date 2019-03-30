FROM maven:3.6.0-jdk-8
LABEL Author=HarpPDX

ARG YCSB_VERSION=0.15.0
ARG HDRH_VERSION=2.1.11
ARG YCSB_DIR=/opt/ycsb
ARG HDRH_DIR=/opt/hdrhistogram
ARG YCSB_URL="https://github.com/brianfrankcooper/YCSB/releases/download/${YCSB_VERSION}/ycsb-${YCSB_VERSION}.tar.gz"
ARG HDRH_URL="https://github.com/HdrHistogram/HdrHistogram/archive/HdrHistogram-${HDRH_VERSION}.tar.gz"

RUN mkdir -p ${YCSB_DIR} && \
curl -L ${YCSB_URL} | tar -C ${YCSB_DIR} --strip-components=1 -xzf -

RUN mkdir -p ${HDRH_DIR} && \
curl -L ${HDRH_URL} | tar -C ${HDRH_DIR} --strip-components=1 -xzf - && \
cd ${HDRH_DIR} && \
mvn install > /dev/null 2>&1

ENV PATH="${YCSB_DIR}/bin:${HDRH_DIR}:${PATH}"
