#!/bin/bash

. ./map.sh

MAP_WIDTH=1
MAP_HEIGHT=3

HORIZONTAL_WALLS=(
    [0]=1
    [1]=0
    [2]=0
    [3]=1
)

VERTICAL_WALLS=(
    [0]=1
    [1]=1
    [2]=1
    [3]=1
    [4]=1
    [5]=1
)

has_wall_at 0 0
if [[ $? -ne 0 ]];
then
    echo 'Failed'
    exit 1
fi

has_wall_at 0 10
echo $?
if [[ $? -ne 0 ]];
then
    echo 'Failed'
    exit 1
fi

