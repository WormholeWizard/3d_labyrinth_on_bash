#!/bin/bash

echo 'Starting engine'

. tan_table.sh
. terminal.sh
. draw.sh
. map.sh
. player.sh

echo "Terminal size ${OUT_WIDTH}/${OUT_HEIGHT}"

SHOULD_EXIT=0

while [ ${SHOULD_EXIT} -ne 1 ]; do

read -s -n 1 -t 0.1 COMMAND
if [ "${COMMAND}" = "q" ]; then
    SHOULD_EXIT=1
fi

if [ -n "${COMMAND}" ]; then
    handle_input_by_player ${COMMAND}
fi

# update_terminal_size
# draw_stub

done;