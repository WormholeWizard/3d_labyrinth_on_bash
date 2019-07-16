#!/bin/bash

echo 'Starting engine'

. precalculated_values.sh
. terminal.sh
. map.sh
. intersection.sh
. player.sh
. draw.sh

update_terminal_size
read_map

echo "Terminal size ${TERMINAL_WIDTH}/${TERMINAL_HEIGHT}"

SHOULD_EXIT=0

while [ ${SHOULD_EXIT} -ne 1 ]
do
    read -s -n 1 COMMAND
    if [ "${COMMAND}" = "q" ]; then
        SHOULD_EXIT=1
    fi

    if [ -n "${COMMAND}" ]; then
        handle_input_by_player ${COMMAND}
    fi

    update_terminal_size
    draw_view

    echo x=${PLAYER_X} y=${PLAYER_Y} angle=${PLAYER_ANGLE}
done