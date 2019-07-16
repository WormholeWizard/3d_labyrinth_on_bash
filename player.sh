#!/bin/bash

PLAYER_X=4
PLAYER_Y=1
PLAYER_ANGLE=89 # north

ANGLE_STEP=3

handle_input_by_player()
{
    local INPUT=${1}
    local temp_angle=${PLAYER_ANGLE}
    case ${INPUT} in
        d) PLAYER_ANGLE=$(( (PLAYER_ANGLE + ANGLE_STEP) % 360 ));;
        a) PLAYER_ANGLE=$(( (PLAYER_ANGLE + 360 - ANGLE_STEP) % 360 ));;
        s) temp_angle=$(( (PLAYER_ANGLE + 180) % 360 ));&
        w)
            local x_shift=0
            local y_shift=0
            if [[ ${temp_angle} -gt 15 && ${temp_angle} -lt 165 ]]
            then
                y_shift=1
            fi
            if [[ ${temp_angle} -gt 195 && ${temp_angle} -lt 345 ]]
            then
                y_shift=-1
            fi

            if [[ ${temp_angle} -gt 255 || ${temp_angle} -lt 75 ]]
            then
                x_shift=1
            fi
            if [[ ${temp_angle} -gt 105 && ${temp_angle} -lt 225 ]]
            then
                x_shift=-1
            fi

            if [[ ${x_shift} -ne 0 ]]
            then
                has_wall_at $(( PLAYER_X + x_shift )) ${PLAYER_Y}
                if [[ $? -ne 0 ]]
                then
                    PLAYER_X=$(( PLAYER_X + x_shift ))
                fi
            fi

            if [[ ${y_shift} -ne 0 ]]
            then
                has_wall_at ${PLAYER_X} $(( PLAYER_Y + y_shift ))
                if [[ $? -ne 0 ]]
                then
                    PLAYER_Y=$(( PLAYER_Y + y_shift ))
                fi
            fi
            ;;
    esac
}

