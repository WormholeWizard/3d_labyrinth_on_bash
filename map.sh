#!/bin/bash

#size in blocks
MAP_WIDTH=1
MAP_LENGTH=1

MAP_BLOCK_SIZE=10

declare -a HORIZONTAL_WALLS
declare -a VERTICAL_WALLS

HORIZONTAL_WALLS=(
    [0]=1
    [1]=1
)

VERTICAL_WALLS=(
    [0]=1
    [1]=1
)

declare INTERSECT_X
declare INTERSECT_Y
declare INTERSECT_WALL

declare get_block_coords_x
declare get_block_coords_y

get_wall_index()
{
    local x_coord=${1}
    local y_coord=${2}
    case ${3} in
        left) return $((y_coord * (MAP_WIDTH + 1) + x_coord));;
        right) return $((y_coord * (MAP_WIDTH + 1) + x_coord + 1));;
        bottom) return $((x_coord * (MAP_HEIGHT + 1) + y_coord));;
        top) return $((x_coord * (MAP_HEIGHT + 1) + y_coord + 1));;
    esac
}

find_intersection()
{
    local pos_x=${1}
    local pos_y=${2}
    local angle=${3}
    local blocK_x=$(( pos_x / 10 ))
    local blocK_y=$(( pos_y / 10 ))

    if [ ${angle} -lt 90 ]; then
        local temp=$(( pox_x + 10 ))
        local wall_x=$(( temp - (temp % 10) ))

        local temp=$(( pox_y + 10 ))
        local wall_y=$(( temp - (temp % 10) ))

        echo $wall_x $wall_y

        local intersect_y=$(( (wall_x - pox_x) * TAN_TABLE[angle] ))

        intersect_y=$(( intersect_y / TAN_MULTI ))

        echo ${intersect_y}

        if [ ${intersect_y} -gt ${wall_y} ]; then
            local wall_index=get_wall_index block_x block_y 'top'
            local wall=${HORIZONTAL_WALLS[wall_index]}
            echo ${wall}
        fi
    fi
}

find_intersection 0 0 89

get_wall_distance()
{
    local player_x = ${1}
    local player_y = ${2}
    local angle = ${3}

}