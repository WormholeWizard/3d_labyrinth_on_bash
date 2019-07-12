#!/bin/bash

PLAYER_X=4
PLAYER_Y=1
PLAYER_ANGLE=89 # north

handle_input_by_player()
{
    local INPUT=${1}

    if [ "${INPUT}" = "d" ]; then
        PLAYER_ANGLE=$(( (PLAYER_ANGLE + 3) % 360 ))
    elif [ "${INPUT}" = "a" ]; then
        PLAYER_ANGLE=$(( (PLAYER_ANGLE + 360 - 3) % 360 ))
    elif [ "${INPUT}" = "w" ]; then
        PLAYER_Y=$(( PLAYER_Y + 1 ))
    elif [ "${INPUT}" = "s" ]; then
        PLAYER_Y=$(( PLAYER_Y - 1 ))
    fi
}

