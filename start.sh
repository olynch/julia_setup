#!/usr/bin/env bash

JUPYTER_PORT=8888

# This is where I have all my git repositories, so it's useful
# to have access to this in the docker container. Change this to something
# useful to you.
SHARED_DIR_HOST=$HOME/g
SHARED_DIR_DOCKER=/g

# This is where I keep the volume that has everything that goes in /root
# in the docker container. Either create this directory, or change it to
# somewhere useful to you
SAVED_ROOT_DIR=$HOME/s/docker-julia-home

# If you don't want X11 support, change this to 0.
ENABLE_X11=1
if [[ ENABLE_X11==1 ]]
then
    X11_ARGS="-v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -h $HOSTNAME -v $HOME/.Xauthority:/root/.Xauthority"
else
    X11_ARGS=
fi

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

    if [[ ENABLE_X11==1 ]]
    then
        # Note, this is insecure for some reason?
        # If you get pwned, don't blame me
        xhost +local:root
    fi
    exec $DOCKER_CMD
fi
