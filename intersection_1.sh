#!/bind/bash

while [ ${have_found} -ne 1 ]; do
    block_x=$(( pos_x / MAP_BLOCK_SIZE ))
    block_y=$(( pos_y / MAP_BLOCK_SIZE ))

    local temp=$(( pos_x + MAP_BLOCK_SIZE ))
    local wall_x=$(( temp - (temp % MAP_BLOCK_SIZE) ))

    local temp=$(( pos_y + MAP_BLOCK_SIZE ))
    local wall_y=$(( temp - (temp % MAP_BLOCK_SIZE) ))

    local intersect_y=$(( pos_y + (wall_x - pos_x) * TAN_TABLE[angle] / TRI_MULTI ))

    if [ ${intersect_y} -gt ${wall_y} ]; then
        get_wall_index block_x block_y 'top'
        local wall_index=$?
        local wall=${HORIZONTAL_WALLS[wall_index]}

        local y_shift=$(( wall_y - pos_y ))
        local x_shift=$(( y_shift * TRI_MULTI / TAN_TABLE[angle] ))

        pos_x=$(( pos_x + x_shift ))
        pos_y=${wall_y}

        if [ ${wall} -eq 1 ]; then
            have_found=1
        fi
    elif [ ${intersect_y} -le ${wall_y} ]; then
        get_wall_index block_x block_y 'right'
        local wall_index=$?
        local wall=${VERTICAL_WALLS[wall_index]}

        pos_x=${wall_x}
        pos_y=${intersect_y}

        if [ ${wall} -eq 1 ]; then
            have_found=1
        elif [ ${intersect_y} -eq ${wall_y} ]; then
            get_wall_index $(( block_x + 1 )) block_y 'top'
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
    local distance=$(( (pos_y - camera_y) * TRI_MULTI / SIN_TABLE[angle] ))
else
    local distance=$(( (pos_x - camera_x) * TRI_MULTI / COS_TABLE[angle] ))
fi