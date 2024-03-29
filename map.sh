#!/bin/bash

MAP_BLOCK_SIZE=10

# size in blocks
declare MAP_WIDTH
declare MAP_HEIGHT

declare -a HORIZONTAL_WALLS
declare -a VERTICAL_WALLS

read_map()
{
    # stub
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
}

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

has_wall_at()
{
    local x_coord=${1}
    local y_coord=${2}

    local block_x=$(( x_coord / MAP_BLOCK_SIZE ))
    local block_y=$(( y_coord / MAP_BLOCK_SIZE ))

    local has_wall=1

    if [[ $(( x_coord % 10)) -eq 0 ]]; then
        get_wall_index block_x block_y 'left'
        if [[ ${VERTICAL_WALLS[$?]} -eq 1 ]]
        then
            has_wall=0
        fi
    fi

    if [[ $(( y_coord % 10)) -eq 0 ]]; then
        get_wall_index block_x block_y 'bottom'
        if [[ ${HORIZONTAL_WALLS[$?]} -eq 1 ]]
        then
            has_wall=0
        fi
    fi

    return ${has_wall}
}