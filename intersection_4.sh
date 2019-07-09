#!/bind/bash

local angle=$(( 360 - angle ))

while [ ${have_found} -ne 1 ]; do
    blocK_x=$(( pos_x / 10 ))
    blocK_y=$(( pos_y / 10 ))

    local temp=$(( pos_x + 10 ))
    local wall_x=$(( temp - (temp % 10) ))

    local temp=$(( pos_y - 10 ))
    # division remainder can be negative in bash
    if [[ temp -lt 0 ]]; then
        local wall_y=0
    else
        local wall_y=$(( temp - (temp % 10) ))
    fi

    local intersect_y=$(( pos_y - (wall_x - pos_x) * TAN_TABLE[angle] / TRI_MULTI ))

    if [ ${intersect_y} -lt ${wall_y} ]; then
        get_wall_index block_x block_y 'bottom'
        local wall_index=$?
        local wall=${HORIZONTAL_WALLS[wall_index]}

        local y_shift=$(( pos_y - wall_y))
        local x_shift=$(( y_shift * TRI_MULTI / TAN_TABLE[angle] ))

        pos_x=$(( pos_x + x_shift ))
        pos_y=${wall_y}

        if [ ${wall} -eq 1 ]; then
            have_found=1
        fi
    else
        get_wall_index block_x block_y 'right'
        local wall_index=$?
        local wall=${VERTICAL_WALLS[wall_index]}

        pos_x=${wall_x}
        pos_y=${intersect_y}

        if [ ${wall} -eq 1 ]; then
            have_found=1
        elif [ ${intersect_y} -eq ${wall_y} ]; then
            get_wall_index $(( block_x + 1 )) block_y 'bottom'
            wall_index=$?
            wall=${HORIZONTAL_WALLS[wall_index]}
            if [ ${wall} -eq 1 ]; then
                have_found=1
            fi
        fi
    fi
done

# not sure if needed
if [ ${angle} -gt 45 ]; then
    local distance=$(( (camera_y - pos_y) * TRI_MULTI / SIN_TABLE[angle] ))
else
    local distance=$(( (pos_x - camera_x) * TRI_MULTI / COS_TABLE[angle] ))
fi