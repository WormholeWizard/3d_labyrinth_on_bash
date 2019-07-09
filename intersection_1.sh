#!/bind/bash

while [ ${have_found} -ne 1 ]; do
    blocK_x=$(( pos_x / 10 ))
    blocK_y=$(( pos_y / 10 ))

    local temp=$(( pox_x + 10 ))
    local wall_x=$(( temp - (temp % 10) ))

    local temp=$(( pox_y + 10 ))
    local wall_y=$(( temp - (temp % 10) ))

    local intersect_y=$(( pos_y + (wall_x - pox_x) * TAN_TABLE[angle] / TAN_MULTI ))

    if [ ${intersect_y} -gt ${wall_y} ]; then
        get_wall_index block_x block_y 'top'
        local wall_index=$?
        local wall=${HORIZONTAL_WALLS[wall_index]}

        local y_shift=$(( wall_y - pos_y ))
        local x_shift=$(( y_shift * TAN_MULTI / TAN_TABLE[angle] ))

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
    local distance=$(( (pos_y - camera_y) *TAN_MULTI / SIN_TABLE[angle] ))
else
    local distance=$(( (pos_x - camera_x) * TAN_MULTI / COS_TABLE[angle] ))
fi