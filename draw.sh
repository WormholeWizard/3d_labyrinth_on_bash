VIEWPORT_ANGLE=70
VIEWPORT_ANGLE_HALF=$(( VIEWPORT_ANGLE / 2 ))

declare -a WALL_SIZES

draw()
{
    local angle_left=$(( (PLAYER_ANGLE + 360 - VIEWPORT_ANGLE_HALF) / 360))
    local angle_right=$(( (PLAYER_ANGLE + VIEWPORT_ANGLE_HALF) / 360))

    for (( ANGLE=${angle_left}; ${ANGLE} != ${angle_right}; ANGLE=$(( (ANGLE + 1) % 360 )) )); do
        find_intersection ${PLAYER_X} ${PLAYER_Y} ${ANGLE}
    done

    for (( LINE=0 ; ${LINE} != ${OUT_HEIGHT} ; (( ++LINE )) )); do
        for (( COL=0 ; ${COL} != ${SHIFT} ; (( ++COL )) )); do
            echo -n '.'
        done;

        for (( COL=${SHIFT} ; ${COL} != ${OUT_WIDTH} ; (( ++COL )) )); do
            echo -n '@'
        done;
    done;
}