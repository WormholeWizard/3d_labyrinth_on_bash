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
    local camera_x=${1}
    local camera_y=${2}
    local angle=${3}

    local pos_x=${1}
    local pos_y=${2}
    local have_found=0

    if [ ${angle} -lt 90 ]; then
        while [ ${have_found} -ne 1 ]; do
            blocK_x=$(( pos_x / 10 ))
            blocK_y=$(( pos_y / 10 ))

            local temp=$(( pox_x + 10 ))
            local wall_x=$(( temp - (temp % 10) ))

            local temp=$(( pox_y + 10 ))
            local wall_y=$(( temp - (temp % 10) ))

            local intersect_y=$(( pos_y + (wall_x - pox_x) * TAN_TABLE[angle] / TAN_MULTI ))

            if [ ${intersect_y} -gt ${wall_y} ]; then
                local wall_index=get_wall_index block_x block_y 'top'
                local wall=${HORIZONTAL_WALLS[wall_index]}

                local y_shift=$(( wall_y - pos_y ))
                local x_shift=$(( y_shift * TAN_MULTI / TAN_TABLE[angle] ))

                pos_x=$(( pos_x + x_shift ))
                pos_y=${wall_y}

                if [ ${wall} -eq 1 ]; then
                    have_found=1
                fi
            elif [ ${intersect_y} -le ${wall_y} ]; then
                local wall_index=get_wall_index block_x block_y 'right'
                local wall=${VERTICAL_WALLS[wall_index]}

                pos_x=${wall_x}
                pos_y=${intersect_y}

                if [ ${wall} -eq 1 ]; then
                    have_found=1
                elif [ ${intersect_y} -eq ${wall_y} ]; then
                    wall_index=get_wall_index $(( block_x + 1 )) block_y 'top'
                    wall=${HORIZONTAL_WALLS[wall_index]}
                    if [ ${wall} -eq 1 ]; then
                        have_found=1
                    fi
                fi
            fi
        done

        # not sure if needed
        if [ ${angle} -gt 45 ]; then
            local distance=$(( (pos_y - camera_y) *TAN_MULTI / SIN_TABLE[angle] ))
        else
            local distance=$(( (pos_x - camera_x) * TAN_MULTI / COS_TABLE[angle] ))
        fi
        echo ${distance}
    fi
}

get_wall_distance()
{
    local player_x = ${1}
    local player_y = ${2}
    local angle = ${3}

}