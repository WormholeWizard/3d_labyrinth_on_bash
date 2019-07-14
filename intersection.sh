#!/bin/bash

find_intersection()
{
    local camera_x=${1}
    local camera_y=${2}
    local angle=${3}

    local pos_x=${1}
    local pos_y=${2}
    local have_found=0

    # hack for now
    if [[ ${angle} -eq 90 ]]; then
        angle=89
    elif [[ ${angle} -eq 270 ]]; then
        angle=269
    fi

    if [ ${angle} -lt 90 ]; then
        . intersection_1.sh
    elif [ ${angle} -lt 180 ]; then
        . intersection_2.sh
    elif [ ${angle} -lt 270 ]; then
        . intersection_3.sh
    elif [ ${angle} -lt 360 ]; then
        . intersection_4.sh
    else
        echo 'INVALID ANGLE' ${angle}
    fi

    return ${distance}
}