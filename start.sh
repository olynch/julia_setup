#!/usr/bin/env bash

JUPYTER_PORT=8888

SHARED_DIR_HOST=$HOME/g
SHARED_DIR_DOCKER=/g

SAVED_ROOT_DIR=$HOME/s/docker-julia-home

X11_ARGS="-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -h $HOSTNAME -v $HOME/.Xauthority:/root/.Xauthority"

CONTAINER_NAME=julia-tex

JUPYTER_LAB_CMD="/root/.julia/conda/3/bin/jupyter lab --ip=0.0.0.0 --allow-root --no-browser"
SHELL_CMD=/bin/bash
INSTALL_JUPYTER_CMD="julia /julia_setup/setup.jl"

SETUP=0

RUN=1

if [[ "$1" == "shell" ]]
then
    CMD=$SHELL_CMD
elif [[ "$1" == "lab" ]]
then
    CMD=$JUPYTER_LAB_CMD
elif [[ "$1" == "setup" ]]
then
    SETUP=1
    CMD=$INSTALL_JUPYTER_CMD
fi


if [[ $SETUP == 1 ]]
then
    docker build -t $CONTAINER_NAME .
fi

if [[ $RUN == 1 ]]
then
    DOCKER_CMD="docker run -it -p $JUPYTER_PORT:$JUPYTER_PORT \
        -v $SHARED_DIR_HOST:$SHARED_DIR_DOCKER \
        -v $SAVED_ROOT_DIR:/root \
        -v $PWD:/julia_setup
        $X11_ARGS \
        $CONTAINER_NAME \
        $CMD"

    xhost +local:root
    exec $DOCKER_CMD
fi
