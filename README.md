# julia_setup

## Description

This is a setup that runs IJulia in a docker container with a mutable volume attached so that packages can be installed "on demand", and also optional X11 support to use, for instance `Gtk.jl` or other graphical apps. Various niceties that are useful for some of the work I do are also preinstalled on the docker container, like TeX and graphviz: you may not need these.

This is a "configure by forking" project; there are a lot of variations of this that would be useful to other people, and I don't plan to have an external config file with those variations, so if you want to change it, you'd better edit some files.

## Prerequisites

I've only tried running this on linux; I have no idea whether it works anywhere else.

The two main dependencies are
- docker
- xhost (for X11 support, optional)


## Instructions:

Read `start.sh` carefully, and note the variables that need changing. Then run `./start.sh setup`, and follow the prompts to get a docker container with jupyter installed through conda. Finally, run `./start.sh lab` to get a jupyter lab, or `./start.sh shell` to get a bash shell in the docker container.
