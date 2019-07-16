VIEWPORT_ANGLE=70
MIN_WALL_HEIGHT=1

declare -a CEILING_SIZES

draw_view()
{
    local step=1

    if [[ ${TERMINAL_WIDTH} -gt ${VIEWPORT_ANGLE} ]]; then
        TERMINAL_WIDTH=${VIEWPORT_ANGLE}
    fi
    local terminal_half=$(( TERMINAL_WIDTH / 2 ))
    [[ $(( TERMINAL_WIDTH % 2 )) -eq 1 ]]
    local terminal_odd=$?
    local view_half=$(( step * terminal_half))
    if [[ ${terminal_odd} -eq 0 ]]; then
        view_half=$(( view_half + (step / 2) ))
    fi
    local angle_first=$(( (PLAYER_ANGLE + view_half) % 360))
    # echo ${step} ${terminal_half} ${terminal_odd} ${view_half} ${angle_first} ${PLAYER_ANGLE}
    local wall_height_max=${TERMINAL_HEIGHT}

    local current_step=0;
    for (( angle=${angle_first}; ${current_step} != ${TERMINAL_WIDTH}; angle=$(( (angle + 360 - step) % 360 )) )); do
        find_intersection ${PLAYER_X} ${PLAYER_Y} ${angle}
        local distance=$?
        # echo ${angle} ${distance}
        local wall_height=$(( wall_height_max - (2 * distance / 3) ))
        if [[ ${wall_height} -le 0 ]]; then
            wall_height=${MIN_WALL_HEIGHT}
        fi
        # echo ${wall_height} ${wall_height_max}
        CEILING_SIZES[${current_step}]=$(( (wall_height_max - wall_height) / 2 ))
        current_step=$(( current_step + 1 ))
    done

    for (( LINE=0 ; ${LINE} != ${TERMINAL_HEIGHT} ; (( ++LINE )) )); do
        for (( COL=0 ; ${COL} != ${TERMINAL_WIDTH} ; (( ++COL )) )); do
            [[ ${LINE} -lt CEILING_SIZES[${COL}] || $(( TERMINAL_HEIGHT - LINE - 1)) -lt CEILING_SIZES[${COL}] ]]
            local is_ceiling=$?
            if [[ ${is_ceiling} -eq 0 ]]; then
                echo -n '.'
            else
                echo -n '#'
            fi
        done
        echo ''
    done
}