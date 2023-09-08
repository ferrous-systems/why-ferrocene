# syntax=docker/dockerfile:1

# Dockerfile for Ferrocene 23.06
#
# Copyright (c) Ferrous Systems, 2023
#
# If you have the ferrocene install files in the CWD, you can run:
#
# docker build . -t ferrocene-23.06 -f ./path/to/this/Dockerfile

FROM --platform=linux/amd64 ubuntu:18.04 as install

RUN apt-get -y update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install xz-utils

COPY cargo-1.68.2-x86_64-unknown-linux-gnu.tar.xz /tmp
COPY ferrocene-docs-1.68.2.tar.xz /tmp
COPY ferrocene-docs-qualification-1.68.2.tar.xz /tmp
COPY ferrocene-self-test-1.68.2-x86_64-unknown-linux-gnu.tar.xz /tmp
COPY llvm-tools-1.68.2-x86_64-unknown-linux-gnu.tar.xz /tmp
COPY rust-src-1.68.2.tar.xz /tmp
COPY rust-std-1.68.2-aarch64-unknown-none.tar.xz /tmp
COPY rust-std-1.68.2-x86_64-unknown-linux-gnu.tar.xz /tmp
COPY rustc-1.68.2-x86_64-unknown-linux-gnu.tar.xz /tmp

ENV FERROCENE_PATH=/opt/ferrocene-23.06

RUN mkdir ${FERROCENE_PATH}

WORKDIR ${FERROCENE_PATH}

RUN tar xvf /tmp/cargo-1.68.2-x86_64-unknown-linux-gnu.tar.xz -C ${FERROCENE_PATH}
RUN tar xvf /tmp/ferrocene-docs-1.68.2.tar.xz -C ${FERROCENE_PATH}
RUN tar xvf /tmp/ferrocene-docs-qualification-1.68.2.tar.xz -C ${FERROCENE_PATH}
RUN tar xvf /tmp/ferrocene-self-test-1.68.2-x86_64-unknown-linux-gnu.tar.xz -C ${FERROCENE_PATH}
RUN tar xvf /tmp/llvm-tools-1.68.2-x86_64-unknown-linux-gnu.tar.xz -C ${FERROCENE_PATH}
RUN tar xvf /tmp/rust-src-1.68.2.tar.xz -C ${FERROCENE_PATH}
RUN tar xvf /tmp/rust-std-1.68.2-aarch64-unknown-none.tar.xz -C ${FERROCENE_PATH}
RUN tar xvf /tmp/rust-std-1.68.2-x86_64-unknown-linux-gnu.tar.xz -C ${FERROCENE_PATH}
RUN tar xvf /tmp/rustc-1.68.2-x86_64-unknown-linux-gnu.tar.xz -C ${FERROCENE_PATH}

FROM --platform=linux/amd64 ubuntu:18.04 as ferrocene

# Update packages
RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

# Install Ferrocene 23.06 dependencies and useful tools
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install gcc-aarch64-linux-gnu gcc build-essential qemu-system-aarch64

ENV FERROCENE_PATH=/opt/ferrocene-23.06
ENV PATH=${PATH}:${FERROCENE_PATH}/bin

COPY --from=install /opt /opt
