SHIFT=0

draw_stub()
{
    for (( LINE=0 ; ${LINE} != ${OUT_HEIGHT} ; (( ++LINE )) )); do
        for (( COL=0 ; ${COL} != ${SHIFT} ; (( ++COL )) )); do
            echo -n '.'
        done;

        for (( COL=${SHIFT} ; ${COL} != ${OUT_WIDTH} ; (( ++COL )) )); do
            echo -n '@'
        done;
    done;
}