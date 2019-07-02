#!/bin/bash

#size in blocks
MAP_WIDTH=10
MAP_LENGTH=10

MAP_BLOCK_SIZE=10

declare -a HORIZONTAL_WALLS
declare -a VERTICAL_WALLS

declare INTERSECT_X
declare INTERSECT_Y
declare INTERSECT_WALL

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

# find_intersection

get_wall_distance()
{
    local player_x = ${1}
    local player_y = ${2}
    local angle = ${3}

}