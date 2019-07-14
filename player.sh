#!/bin/bash

PLAYER_X=4
PLAYER_Y=1
PLAYER_ANGLE=89 # north

ANGLE_STEP=3

handle_input_by_player()
{
    local INPUT=${1}

    if [ "${INPUT}" = "d" ]; then
        PLAYER_ANGLE=$(( (PLAYER_ANGLE + ANGLE_STEP) % 360 ))
    elif [ "${INPUT}" = "a" ]; then
        PLAYER_ANGLE=$(( (PLAYER_ANGLE + 360 - ANGLE_STEP) % 360 ))
    elif [ "${INPUT}" = "w" ]; then
        PLAYER_Y=$(( PLAYER_Y + 1 ))
    elif [ "${INPUT}" = "s" ]; then
        PLAYER_Y=$(( PLAYER_Y - 1 ))
    fi
}

